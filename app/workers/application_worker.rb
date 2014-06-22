class ApplicationWorker

  include Sidekiq::Worker
  include Sidekiq::ProgressBar

  DEFAULT_QUEUE = Rails.application.class.to_s.split('::').first.underscore.dup.freeze
  DEFAULT_RETRY = false

  sidekiq_options queue: (( defined? QUEUE ) ? QUEUE : DEFAULT_QUEUE ), retry: !!(( defined? RETRY ) ? RETRY : DEFAULT_RETRY )

  # a thin wrapper around perform_async that (a) sanitizes arguments and (b) executes jobs inline for development and test purposes
  # note: using this is not an excuse to not know what you're doing
  def self.run( *args )
    args.map!{ |arg| ( arg.class <= ActiveRecord::Base ) ? arg.id : arg } # you shouldn't throw model objects at a sidekiq worker, but if you do...
    ( Rails.env.development? || Rails.env.test? ) ? self.new.perform( *args ) : self.perform_async( *args )
  end

end
