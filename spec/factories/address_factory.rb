FactoryGirl.define do

  factory :address do

    line1       { Faker::Address.street_address }
    line2       { 70.percent_chance{ Faker::Address.secondary_address } }
    city        { Faker::Address.city }
    state       { Address::STATES.keys.sample }
    zip         { Faker::Address.zip_code }

    phone       { Faker::PhoneNumber.phone_number }

    addressable { ( 100 - User.count ).percent_chance ? create( :user ) : User.all.sample }

  end

end
