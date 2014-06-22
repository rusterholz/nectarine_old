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

# include all ruby files in the lib directory, including our patches
Dir[ Rails.root.join *%w(lib *.rb) ].each do |file|
  require file
end

# set up paper_trail
require 'paper_trail'
PaperTrail.serializer = PaperTrail::Serializers::JSON

# set up faker
require 'faker'
Faker::Config.locale = 'en-us'

# set up geocoder
require 'geocoder'
Geocoder.configure({
  lookup:       :google,      # what service to connect to
  ip_lookup:    :freegeoip,   # what service to use for ip geocoding
  timeout:      2.5,          # request timeout (default 3)
  units:        :km,          # default units
  cache:        Rails.cache,  # cache
  cache_prefix: "geocoder_#{Rails.application.class.to_s.split('::').first.underscore}_#{Rails.env}:"
})



# keep hacks and monkeypatches below this line!
# --------------------------------------------------------------------------------------


# monkeypatch the incompatibilities between rails 4.1 and state_machine
require 'state_machine/version'
Rails.logger.warn "state_machine has finally been upgraded -- please try removing these patches!" unless StateMachine::VERSION == '1.2.0'

# https://github.com/pluginaweek/state_machine/issues/295
module StateMachine::Integrations::ActiveModel
  public :around_validation
end

# https://github.com/pluginaweek/state_machine/issues/279
StateMachine::Machine.class_eval do
  alias_method :_original_initial_state=, :initial_state=
  def initial_state=( new_initial_state )
    _original_initial_state=( new_initial_state ) unless new_initial_state.nil?
  end
end


# until I can figure out a better way to get rails to require these, I'll do it here.
Dir[ Rails.root.join *%w(app workers concerns *) ].each do |file|
  require file
end
