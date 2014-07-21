require 'rails_helper'

RSpec.describe "contacts/index", :type => :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :age => 1,
        :gender => "Gender",
        :ethnicity => "Ethnicity",
        :description => "MyText",
        :contactable_type => "Contactable Type",
        :contactable_id => 2
      ),
      Contact.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :age => 1,
        :gender => "Gender",
        :ethnicity => "Ethnicity",
        :description => "MyText",
        :contactable_type => "Contactable Type",
        :contactable_id => 2
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Ethnicity".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Contactable Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
