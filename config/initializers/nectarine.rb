module Nectarine
  module Version

    MAJOR = 0
    MINOR = 1
    PATCH = 0

    COMMIT = ( `git describe --always` rescue '' ).freeze unless defined? COMMIT

    def self.to_s
      self.version
    end

    def self.version
      "#{MAJOR}.#{MINOR}.#{PATCH}" + ( COMMIT.empty? ? '' : " - #{COMMIT}" )
    end
  end
end

# set up hirb
if defined? Rails::Console
  require 'hirb'
  Hirb.enable pager: false and puts 'Hirb enabled' # spring won't rerun this initializer file, so if you aren't seeing this message, you know Hirb isn't enabled
end

# set up chronic
require 'chronic'
Chronic.time_class = Time.zone # makes Chronic parse into dates/times in the server's time zone

# set up paper_trail
require 'paper_trail'
PaperTrail.serializer = PaperTrail::Serializers::JSON

# require other libraries and gems here, or in specific places