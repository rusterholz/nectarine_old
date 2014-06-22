unless ( defined? Sidekiq::ProgressBar ) # sidekiq will crash without this wrapper

  module Sidekiq
    module ProgressBar
      extend ActiveSupport::Concern

      COMPLETE    = 'Complete'
      IN_PROGRESS = lambda { |n,total| "#{n} of #{total}" }

      included do
        include Sidekiq::Status::Worker
      end

      # usage: progress_bar( current_count, total_count, { color: bar_color, active: barber_pole_style?, halt: should_client_stop_updating?, your_key: your_data } )
      def progress_bar( *args )
        args.extract_options!.each{ |k,v| store( { k => v.to_s } ) }
        total ( args.second || args.first )
        at args.first, (
          case args.first
          when String
            args.first.strip
          else 
            ( args.first == ( args.second || args.first ) ) ? COMPLETE : IN_PROGRESS.call( *args[0..1] )
          end
        )
      end

    end
  end

end