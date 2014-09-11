class ApplicationWorker

  include Sidekiq::Worker
  include Sidekiq::ProgressBar

  DEFAULT_QUEUE = Rails.application.class.to_s.split('::').first.underscore.dup.freeze
  DEFAULT_RETRY = false

  sidekiq_options queue: (( defined? QUEUE ) ? QUEUE : DEFAULT_QUEUE ), retry: !!(( defined? RETRY ) ? RETRY : DEFAULT_RETRY )

end
