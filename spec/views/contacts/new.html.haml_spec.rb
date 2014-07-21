require 'rails_helper'

RSpec.describe "contacts/new", :type => :view do
  before(:each) do
    assign(:contact, Contact.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :age => 1,
      :gender => "MyString",
      :ethnicity => "MyString",
      :description => "MyText",
      :contactable_type => "MyString",
      :contactable_id => 1
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_first_name[name=?]", "contact[first_name]"

      assert_select "input#contact_last_name[name=?]", "contact[last_name]"

      assert_select "input#contact_age[name=?]", "contact[age]"

      assert_select "input#contact_gender[name=?]", "contact[gender]"

      assert_select "input#contact_ethnicity[name=?]", "contact[ethnicity]"

      assert_select "textarea#contact_description[name=?]", "contact[description]"

      assert_select "input#contact_contactable_type[name=?]", "contact[contactable_type]"

      assert_select "input#contact_contactable_id[name=?]", "contact[contactable_id]"
    end
  end
end
