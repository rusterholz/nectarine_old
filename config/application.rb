require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nectarine

  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Paths from which Rails should autoload class definitions
    config.autoload_paths += %W(#{config.root}/app/workers)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # use memcached as our cache provider
    config.cache_store = :mem_cache_store

    # configure factorygirl to generate factory files of the form "<model>_factory.rb"
    config generators do |g|
      g.factory_girl suffix: 'factory'
    end

  end

  class << self
    def process_name
      ActiveSupport::StringInquirer.new($0.split('/').last)
    end
    def websocket_process?
      !!( process_name.rake? && /websocket_rails/ =~ ARGV.join(' ') )
    end
  end

end
