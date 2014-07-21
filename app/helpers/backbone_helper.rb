module BackboneHelper

  def backbone_collection_tag( **collections )
    collections.map do |name,set|
      hidden_field_tag "backbone_collection_#{name}", "{\"#{name}\":[#{set.map(&:backbone_json).join(',')}]}", style: 'display: none;'
    end.join.html_safe
  end

end
