# This is a collection of several different small monkeypatches and extensions to base classes.

class Object

  # This assists with the conversion of hashes and arrays to OpenStructs.
  # See the OpenStruct documentation for details.
  def to_struct
    self
  end

end


class Integer

  # Allows integers to be converted to symbols.
  def to_sym
    self.to_s.to_sym
  end

  # Returns an array with N executions of the block as the values. The block can accept
  # an |index| parameter, which starts at 0 and runs up to N-1. Returns nil if called
  # on a negative integer.
  #
  # Example:
  #   wishes_granted = 3.instances_of{ Wish.new }
  #
  def instances_of( *args, &block )
    if self == 0
      []
    elsif self < 0
      nil
    else
      (0..( self - 1 )).map( *args, &block )
    end
  end

  # Simple method that returns true X percent of the time, where X is the current value.
  # Values of 100 or greater always return true. Values of 0 or less always return false.
  #
  # Example:
  #   send_winning_ticket if 5.percent_chance
  #
  def percent_chance
    !!( rand( 100 ) < self )
  end

end

class Float

  # Probability method that returns true (self) times per 1 invocation. Returns true for
  # values higher than normalized range, false for values lower than the range. Within the
  # range interval [0,1], pseudorandomly returns true or false, with an expected value of
  # (self) trues per 1 invocation.
  #
  # Example:
  #   send_winning_ticket if (0.0875).chance
  #
  def chance
    if self >= 1
      true
    elsif self <= 0
      false
    else
      !!( rand( self.denominator ) < ( self.numerator ) )
    end
  end

  # Pseudorandomly return true (self) percent of the time. Normalized as a percentage,
  # where 100 is certain and 0 is impossible. Returns true for values higher than normalized
  # range, false for values lower than the range. Within the range interval [0,100], pseudorandomly
  # returns true or false, with an expected value of (self) trues per 100 invocations.
  #
  # Example:
  #   send_winning_ticket if (8.75).percent_chance
  #
  def percent_chance
    ( self / 100 ).chance
  end

end


class String

  # Replaces five particularly dangerous characters with their HTML entities. This is not normally
  # needed since Rails handles most of this via SafeBuffer, but for text going out over JSON, this
  # can be useful.
  #
  # Example:
  #   '"5 < 8 & 16 > 10," she said.'.entitize! --------> '&quot;5 &lt; 8 &amp; 16 &gt; 10,&quot; she said.'
  #
  def entitize!
    { '&' => '&amp;', "\\" => '&#92;', '<' => '&lt;', '>' => '&gt;', '"' => '&quot;' }.each do |raw, entity|
      gsub!( raw, entity )
    end
    self
  end
  # Non-destructive form of the same.
  def entitize
    dup.entitize!
  end

  # Mutates this string into a canonical form of a date/time string. Useful for preprocessing human-entered
  # strings into reasonable data before assigning into attributes. Requires the Chronic gem to be installed
  # and properly configured. See http://github.com/mojombo/chronic or http://rubygems.org/gems/chronic
  #
  # Examples:
  #   'next thursday'.chronitize!                 -------> '2013-05-30 12:00:00'
  #   'next thursday'.chronitize! :datetime, true -------> '2013-05-30 12:00:00 -0500'
  #   'next thursday'.chronitize! :date           -------> '2013-05-30'
  #
  # Best Usage (in a controller method):
  #   params[ :appointment ][ :day ].chronitize!
  #   @appointment = Appointment.new( params[ :appointment ] )
  #
  def chronitize!( type = :datetime, zoned = false )
    if( c = Chronic.parse( self ) )
      self.gsub!( self, c.strftime(
        case type
        when :datetime then ( zoned ? '%F %T %z' : '%F %T' )
        when :date then '%F'
        when :time then ( zoned ? '%T %z' : '%T' )
        end
      ) )
    end
    self
  end
  # Non-destructive form of the same.
  def chronitize( type = :datetime, zoned = false )
    dup.chronitize!( type, zoned )
  end

  # Removes all HTML tags from a string.
  def strip_tags
    ActionController::Base.helpers.strip_tags( self )
  end
  # Destructive form of the same.
  def strip_tags!
    gsub!( self, self.strip_tags )
  end

  # Removes unnecessary whitespace by collapsing all runs of multiple whitespace characters
  # into single spaces, and stripping the result.
  def collapse
    gsub( /\s+/, ' ' ).strip
  end
  # Destructive form of the same.
  def collapse!
    gsub!( /\s+/, ' ' ).strip!
  end

  # Shorthand for hashing strings. You can pass any symbol or string corresponding to any
  # of the subclasses of Digest: :md5, :MD4, :sha256, :SHA512, :ripemd160, and so on.
  # Returns hex string by default; pass true as a second argument to get raw binary.
  def digest( algorithm, binary = false )
    h = "OpenSSL::Digest::#{algorithm.to_s.upcase}".constantize.digest( self )
    binary ? h : h.unpack('H*')[0]
  end

end


class Range

  # This makes it just slightly more elegant to pull a random number from a range.
  def sample( *args )
    self.to_a.sample( *args )
  end

end


class Array

  # This assists with the conversion of hashes and arrays to OpenStructs.
  # See the OpenStruct documentation for details.
  def to_struct
    map{ |x| x.to_struct }
  end

  # Makes a deep copy (as opposed to .clone's shallow copy). Be aware that if the
  # array contains any procs or lambdas, this will fail and raise an exception!
  #
  # Example:
  #   params_to_modify = params.deep_clone
  #
  def deep_clone
    Marshal.load( Marshal.dump( self ) )
  end

  # Puts an array of objects into a hash keyed by the specified attribute, or the result of a
  # block passed in. Useful to sort or filter a list of objects by a single attribute or method.
  #
  # Examples:
  #   Office.all.to_hash_keyed_by                  --------> { 1 => <Office 1>, 2 => <Office 2> ... }
  #   Office.all.to_hash_keyed_by :name            --------> { 'Chicago' => <Office 1>, 'Dallas' => <Office 2> ... }
  #   Office.all.to_hash_keyed_by{ |o| o.name[0] } --------> { 'C' => <Office 1>, 'D' => <Office 2> ... }
  #
  def to_hash_keyed_by( attribute = :id )
    Hash[*(map{ |el| [ ( block_given? ? yield( el ) : el.send( attribute.to_sym ) ), el] }).flatten(1)]
  end

  # Puts an array of objects into a hash keyed by the selfsame object, i.e. x => x, y => y, etc.
  # This can be useful for dropdowns and radio buttons where the text of each option is the same as
  # the value of that option.
  #
  # Example:
  #   STATES = [ 'AL', 'AK', ... 'WI', 'WY' ]
  #   STATES.to_hash_of_selves --------> { 'AL' => 'AL', 'AK' => 'AK', ... 'WI' => 'WI', 'WY' => 'WY' }
  #
  # Best Usage (in a view template):
  #   form_for( @address ) do |f|
  #     f.select :state, STATES.to_hash_of_selves
  #
  def to_hash_of_selves
    Hash[*(map{ |el| [el, el] }).flatten(1)]
  end

  # Puts an array of objects into a hash where the keys are the result of passing the first symbol
  # to each object, and the values are the result of passing the second symbol to that object.
  #
  # Examples:
  #   Office.all.to_hash_by_methods :name, :get_latlon          --------> { "Chicago" => [ 82.53, 58.19 ], "Dallas" => [ -42.09, 19.38 ] ... }
  #
  def to_hash_by_methods( m1, m2 )
    Hash[*(map{ |el| [el.send( m1 ), el.send( m2 )] }).flatten(1)]
  end

  # Attempts to cast every element in the array to a symbol. If an element cannot be directly
  # converted, it attempts to cast it to a string and then cast that string to a symbol.
  #
  # Example:
  #   [ 'twist', 5, :duck, 3.99 ].symbolize! -------> [ :twist, :"5", :duck, :"3.99" ]
  #
  def symbolize!
    map! do |e|
      begin
        e.to_sym
      rescue NoMethodError
        e.to_s.to_sym
      end
    end
  end
  # Non-destructive form of the same
  def symbolize
    dup.symbolize!
  end

  # Oxford-comma-conscious join of lists. Also pays attention to the first letter of the word so
  # as to pick the correct article to apply (a or an). Returns nil if there is nothing in the list.
  #
  # Examples:
  #   %w( director ).oxford_join                             -------> 'a director'
  #   %w( director actor ).oxford_join                       -------> 'a director and an actor'
  #   %w( director actor writer ).oxford_join                -------> 'a director, an actor, and a writer'
  #   %w( director actor writer producer ).oxford_join       -------> 'a director, an actor, a writer, and a producer'
  #   %w( director actor writer producer ).oxford_join false -------> 'director, actor, writer, and producer'
  #
  def oxford_join( articles = true )
    prepared = map(&:to_s)
    prepared.map!{ |e| "a#{ /^[aeiou]/i.match( e ) && 'n'} #{e}" } if articles
    case prepared.length
    when 0
      nil
    when 1
      prepared.first
    when 2
      prepared.join( ' and ' )
    else
      prepared.push( "and #{prepared.pop}" ).join( ', ' )
    end
  end

  # Returns a value between 0 and 1 indicating the fraction of elements in this array which are truthy,
  # i.e. the fraction of elements for which !!element === true. Returns 0 if the array is empty.
  def fraction_truthy
    count > 0 ? select{ |e| !!e }.count / count.to_f : 0
  end

  # Returns a value between 0 and 1 indicating the fraction of elements in this array which are falsey,
  # i.e. the fraction of elements for which !!element === false. Returns 0 if the array is empty.
  def fraction_falsey
    count > 0 ? 1 - fraction_truthy : 0
  end

end


class Hash

  # This converts the hash, and all nested objects, into an OpenStruct. It can be
  # especially useful for packing up some data which will be later returned as JSON
  # to the client. See the OpenStruct documentation for details.
  def to_struct
    mapped = {}
    each{ |key,value| mapped[ key ] = value.to_struct }
    OpenStruct.new( mapped )
  end

  # Makes a deep copy (as opposed to .clone's shallow copy). Be aware that if the
  # hash contains any procs or lambdas, this will fail and raise an exception!
  #
  # Example:
  #   params_to_modify = params.deep_clone
  #
  def deep_clone
    Marshal.load( Marshal.dump( self ) )
  end

end


# Returns the number of days in the month that is represented by the current Date/Time object.
#
# Example:
#   Time.zone.now.days_in_month -------> 31
#
class Time
  def days_in_month
    Time.send( :month_days, self.year, self.month )
  end
end
class Date
  def days_in_month
    Time.send( :month_days, self.year, self.month )
  end
end
class DateTime
  def days_in_month
    Time.send( :month_days, self.year, self.month )
  end
end