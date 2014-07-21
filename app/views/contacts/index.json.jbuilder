json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :birthdate, :age, :gender, :ethnicity, :description, :contactable_type, :contactable_id
  json.url contact_url(contact, format: :json)
end
