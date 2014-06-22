module AddressesHelper

  def address_id( address )
    address.id.try( :to_s ) || missing_field
  end

  def address_title( address )
    address.title || missing_field
  end

  def address_line1( address )
    address.line1 || missing_field
  end

  def address_line2( address )
    address.line2 || missing_field
  end

  def address_city( address )
    address.city || missing_field
  end

  def address_state( address )
    address.state || missing_field
  end

  def address_zip( address )
    address.zip || missing_field
  end

  def address_country( address )
    address.country || missing_field
  end

  def address_phone( address )
    address.phone || missing_field
  end

  def address_addressable( address )
    address.addressable.try( :to_s ) || missing_field
  end

  def address_city_state_zip( address )
    address.city_state_zip || missing_field
  end

  def address_street_address( address )
    address.street_address || missing_field
  end

  def address_location( address )
    address.location || missing_field
  end

  def address_state_name( address )
    address.state_name || missing_field
  end

  def address_latitude( address )
    address.latitude ? number_with_precision( address.latitude, precision: 3 ) : missing_field
  end

  def address_longitude( address )
    address.longitude ? number_with_precision( address.longitude, precision: 3 ) : missing_field
  end

end
