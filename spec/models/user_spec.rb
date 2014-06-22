require 'rails_helper'

RSpec.describe User, type: :model do

  pending "not sure how to get these working" do
    it{ should normalize_attribute( :last_callsign ).from(' red  XIII ').to('red xiii') }
    it{ should normalize_attribute( :last_callsign ).from('   ').to( nil ) }
  end

  it "should default status to active" do
    expect( User.new.status ).to eq 'active'
  end

  context "fresh from the factory" do

    before :each do
      @user = FactoryGirl.build( :user )
    end

    it "should be valid" do
      expect( @user.valid? ).to eq true
    end

    it "should transition between statuses" do
      @user.save!
      @user.disable!
      expect( @user.reload.status ).to eq 'disabled'
      @user.activate!
      expect( @user.reload.status ).to eq 'active'
    end

  end

end
