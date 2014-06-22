json.array!(@addresses) do |address|
  json.extract! address, :id, :addressable_type, :addressable_id, :line1, :line2, :city, :state, :zip, :country, :phone, :latitude, :longitude
  json.url address_url(address, format: :json)
end
