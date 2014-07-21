require 'rails_helper'

RSpec.describe "contacts/show", :type => :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :age => 1,
      :gender => "Gender",
      :ethnicity => "Ethnicity",
      :description => "MyText",
      :contactable_type => "Contactable Type",
      :contactable_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Ethnicity/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Contactable Type/)
    expect(rendered).to match(/2/)
  end
end
