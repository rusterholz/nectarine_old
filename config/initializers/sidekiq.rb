module Nectarine

  SIDEKIQ_REDIS_CONFIG = {
    development: {
      url: 'redis://localhost:6379',
      namespace: "#{Rails.application.class.to_s.split('::').first.underscore}_#{Rails.env}_sidekiq",
      driver: :hiredis
    },
    test: {
      url: 'redis://localhost:6379',
      namespace: "#{Rails.application.class.to_s.split('::').first.underscore}_#{Rails.env}_sidekiq",
      driver: :hiredis
    },
    staging: {
      # fill me out
    },
    production: {
      # fill me out
    }
  }

  SIDEKIQ_EXPIRATION = {
    development: 30.minutes,
    test:        10.minutes,
    staging:     10.minutes,
    production:  30.minutes
  }

end

unless Nectarine.websocket_process?

  require 'sidekiq'
  require 'sidekiq-status'

  Sidekiq.configure_client do |config|
    config.redis = Nectarine::SIDEKIQ_REDIS_CONFIG[ Rails.env.to_sym ]
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware
    end
  end

  Sidekiq.configure_server do |config|
    config.redis = Nectarine::SIDEKIQ_REDIS_CONFIG[ Rails.env.to_sym ]
    config.server_middleware do |chain|
      chain.add Sidekiq::Status::ServerMiddleware, expiration: Nectarine::SIDEKIQ_EXPIRATION[ Rails.env.to_sym ]
    end
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware
    end
  end
end

Sidekiq::Mailer.excluded_environments = [ :test ]
