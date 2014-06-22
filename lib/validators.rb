# validates that an email address is properly formatted
# based on http://lindsaar.net/2010/1/31/validates_rails_3_awesome_is_true with a couple of tweaks.
class EmailValidator < ActiveModel::EachValidator

  FORMAT = Regexp.compile(/(?<email>\A[A-Za-z0-9!$#%&'*+\/=?^_`{|}~-]+(?:\.[A-Za-z0-9!$#%&'*+\/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\z)/)

  def validate_each( record, attribute, value )
    if value
      unless match = FORMAT.match(value)
        record.errors.add( attribute.to_sym, ( options[ :message ] || "invalid email address" ) )
      end
    else
      if !record.errors[ attribute ].include?( "can't be blank" )
        record.errors.add( attribute, "can't be blank" )
      end
    end
  end

end


# validates that a phone number is properly formatted
class PhoneValidator < ActiveModel::EachValidator

  def validate_each( record, attribute, value )
    raw = value.to_s.gsub( /[^0-9]/, '' ).strip
    raw = raw[1...raw.length] if raw[0] == '1' # initial 1 is a long-distance token, drop it
    unless ( raw.length == 10 )
      record.errors.add( attribute.to_sym, ( options[ :message ] || "invalid phone number" ) )
    end
  end

end


# validates that a social security number is correctly formatted, has no invalid subcodes, and is not a known fake
class SsnValidator < ActiveModel::EachValidator

  KNOWN_INVALID_NUMBERS = [
    '078051120',    # Hilda S. Whitcher -- http://www.ssa.gov/history/ssn/misused.html
    '219099999',    # 1940 Pamphlet -- http://www.ssa.gov/history/ssn/misused.html
    '222556789',    # dummy placeholder SSN used by some payroll companies (incl. Paychex) - not real
    '457555462'     # Todd "Lifelock" Davis -- http://en.wikipedia.org/wiki/Todd_Davis
  ].freeze

  def validate_each( record, attribute, value )
    if value
      raw = value.to_s.gsub( /[^0-9]/, '' ).strip
      if(
          raw.length != 9 ||                                        # wrong length
          raw.first == '9' ||                                       # only non-SSN TINs start with 9
          [ '000', '666' ].include?( raw[0..2] ) ||                 # no SSNs have these area numbers
          raw[3..4] == '00' ||                                      # no SSNs have this group number
          raw[5..8] == '0000' ||                                    # no SSNs have this serial number
          raw[0..7] == '98765432' ||                                # these ten SSNs are reserved for ads and movies
          raw.split(//).uniq.count == 1 ||                          # SSNs consisting of all one digit are invalid
          KNOWN_INVALID_NUMBERS.include?( raw )                     # well-known fake or abused ssns
        )
        record.errors.add( attribute.to_sym, ( options[ :message ] || "invalid ssn" ) )
      end
    else
      record.errors.add(attribute, "invalid ssn")
    end
  end

end


# validates that a zipcode is properly formatted
class ZipcodeValidator < ActiveModel::EachValidator

  def validate_each( record, attribute, value )
    raw = value.to_s.gsub( /[^0-9]/, '' ).strip
    unless ( raw.length == 5 || raw.length == 9 )
      record.errors.add( attribute.to_sym, ( options[ :message ] || "invalid zip code" ) )
    end
  end

end
