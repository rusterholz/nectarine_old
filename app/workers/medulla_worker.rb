class MedullaWorker < ApplicationWorker

  QUEUE = 'medulla'
  PRECISION = 1000000 # microseconds

  class << self
    def announce_update_of( model )
      self.announce( 'update', model )
    end
    def announce_creation_of( model )
      self.announce( 'create', model )
    end
    def announce_deletion_of( model )
      self.announce( 'delete', model, id_only: true )
    end
    def announce( event, model, id_only: false )
      self.perform_async( model.class.to_s.pluralize.underscore, event, ( id_only ? { id: model.id } : model.as_json_for_medulla ), ( Time.now.to_f * PRECISION ).to_i )
    end
  end

  def perform( channel = 'pulses', event = 'pulse', object = {}, timestamp = 0 )
    self.broadcast( channel, event, object ) if self.causality_holds?( channel, timestamp )
  end

  def causality_holds?( channel, timestamp )
    previous = ( @@last_events ||= {}.with_indifferent_access )[ channel ] || 0
    if timestamp > previous
      @@last_events[ channel ] = timestamp
      true
    else
      false
    end
  end

  def broadcast( channel, event, object = {} )
    puts "broadcasting '#{event}' on '#{channel}'"
    WebsocketRails[ channel ].trigger( event, object )
  end

end
