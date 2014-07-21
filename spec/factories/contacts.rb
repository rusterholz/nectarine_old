# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    first_name "MyString"
    last_name "MyString"
    birthdate "2014-06-22"
    age 1
    gender "MyString"
    ethnicity "MyString"
    description "MyText"
    contactable_type "MyString"
    contactable_id 1
  end
end
