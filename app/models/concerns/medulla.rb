module Medulla
  extend ActiveSupport::Concern

  included do
    class << self
      def medulla_attributes( *atts )
        @_medulla_attributes = atts.map(&:to_sym) unless atts.empty?
        @_medulla_attributes
      end
    end
    after_create  :announce_creation
    around_update :announce_update
    after_destroy :announce_deletion
  end

  def to_json_for_medulla
    self.as_json_for_medulla.to_json
  end

  def as_json_for_medulla
    self.as_json( root: false, only: self.class.medulla_attributes )
  end

  protected

  def announce_update
    modified = self.changed?
    yield
    MedullaWorker.announce_update_of( self ) if modified
    true
  end

  def announce_creation
    MedullaWorker.announce_creation_of( self )
  end

  def announce_deletion
    MedullaWorker.announce_deletion_of( self )
  end

end
