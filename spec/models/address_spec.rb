require 'rails_helper'

RSpec.describe Address, type: :model do

  it{ should validate_presence_of :addressable }
  it{ should ensure_inclusion_of( :state ).in_array( Address::STATES.keys ) }

  it{ should normalize_attribute( :title    ).from('  the CRAZY  address Title ').to('The Crazy Address Title') }
  it{ should normalize_attribute( :line1    ).from(' 212  n. 5TH ave').to('212 N. 5th Ave') }
  it{ should normalize_attribute( :line2    ).from('apt.  104 ').to('Apt. 104') }
  it{ should normalize_attribute( :line2    ).from('   ').to( nil ) }
  it{ should normalize_attribute( :city     ).from(' wallyVille  WEST  ').to('Wallyville West') }
  it{ should normalize_attribute( :state    ).from(' bz').to('BZ') }
  it{ should normalize_attribute( :zip      ).from(' 54 02 3').to('54023') }
  it{ should normalize_attribute( :zip      ).from('3  0  438 0').to('30438-0') }
  it{ should normalize_attribute( :zip      ).from('68.1.027  910').to('68102-7910') }
  it{ should normalize_attribute( :country  ).from(' france ').to('FRANCE') }
  it{ should normalize_attribute( :phone    ).from('17156926971').to('(715) 692-6971') }
  it{ should normalize_attribute( :phone    ).from('308.569.1102').to('(308) 569-1102') }
  it{ should normalize_attribute( :phone    ).from('280 912 6023 x4399').to('(280) 912-6023') }
  it{ should normalize_attribute( :phone    ).from('1 800-594.73,87').to('(800) 594-7387') }

  it{ should belong_to( :addressable ) }

  context 'fresh from the factory' do
    before :each do
      @address = FactoryGirl.build( :address )
    end

    it 'should be valid' do
      expect( @address.valid? ).to eq true
    end

    context 'with known values' do
      before :each do
        @address = FactoryGirl.create( :address, title: 'Home', line1: '1382 N. Osceola Ave.', line2: 'Unit F', city: 'Morovia', state: 'WI', zip: '91528', phone: '(302) 918-4820' )
      end

      it 'should format the city, state, and zip' do
        expect( @address.city_state_zip ).to eq 'Morovia, WI 91528'
      end

      it 'should format the street address' do
        expect( @address.street_address ).to eq '1382 N. Osceola Ave. Unit F'
      end

      it 'should format the location without the second line' do
        expect( @address.location ).to eq '1382 N. Osceola Ave., Morovia, WI 91528'
      end

      it 'should provide the full name of the state' do
        expect( @address.state_name ).to eq 'Wisconsin'
      end
    end

  end

end
