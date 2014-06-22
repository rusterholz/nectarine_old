require 'attribute_normalizer'

AttributeNormalizer.configure do |config|

  config.normalizers[ :decimal ] = lambda do |val, options|
    val.is_a?( String ) ? val.gsub(/[^0-9\.]+/, '') : val
  end

  config.normalizers[ :collapse ] = lambda do |val, options|
    val.is_a?( String ) ? val.collapse : val
  end

  config.normalizers[ :upcase ] = lambda do |val, options|
    val.is_a?( String ) ? val.upcase : val
  end

  config.normalizers[ :downcase ] = lambda do |val, options|
    val.is_a?( String ) ? val.downcase : val
  end

  config.normalizers[ :propercase ] = lambda do |val, options|
    val.is_a?( String ) ? val.downcase.titlecase : val
  end

  config.normalizers[ :zipcode ] = lambda do |val, options|
    val.nil? ? nil : ( val.blank? ? '' : (
      z = val.to_s.gsub( /[^0-9]/, '' )
      ( z.length > 5 ? "#{z[0..4]}-#{z[5...z.length]}" : z )  # allow trailing invalid digits here, validators will pick them up
    ))
  end

  config.normalizers[ :phone ] = lambda do |val, options|
    val.nil? ? nil : ( val.blank? ? '' : (
      p = val.to_s.gsub( /[^0-9x]/, '' ).split(/x/).first     # eliminate all non-digits and drop any extension codes
      p = p[1...p.length] if p[0] == '1'                      # drop any initial long-distance digit
      "(#{p[0..2]}) #{p[3..5]}-#{p[6...p.length]}"            # format to my liking, allowing trailing invalid digits
    ))
  end

  config.default_normalizers = :collapse

end
