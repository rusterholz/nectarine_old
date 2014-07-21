module Backbone
  extend ActiveSupport::Concern

  included do
    class << self
      def backbone_attributes( *atts )
        @_backbone_attributes = atts.map(&:to_sym) unless atts.empty?
        @_backbone_attributes
      end
    end
  end

  def backbone_json
    self.as_json( root: false, only: self.class.backbone_attributes ).to_json
  end

end
