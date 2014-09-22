module MedullaHelper

  def medulla_collection_tag( **collections )
    collections.map do |name,set|
      hidden_field_tag "medulla_collection_#{name}", "{\"#{name}\":[#{set.map(&:to_json_for_medulla).join(',')}]}", style: 'display: none;'
    end.join.html_safe
  end

end
