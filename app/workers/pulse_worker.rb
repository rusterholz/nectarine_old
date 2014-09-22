class PulseWorker < ApplicationWorker

  def perform( *args )
    puts "pulsing!"
    result = WebsocketRails[:pulses].trigger('pulse', args.extract_options! )
    puts result.inspect
  end

end
