class Address < ActiveRecord::Base

  # constants # --------------------------------------------------------------------------------------------------

  STATES = { 'AL' => 'Alabama', 'AK' => 'Alaska', 'AS' => 'American Samoa', 'AZ' => 'Arizona', 'AR' => 'Arkansas', 'AA' => 'Armed Forces Americas', 'AE' => 'Armed Forces Europe/Other', 'AP' => 'Armed Forces Pacific', 'CA' => 'California', 'CO' => 'Colorado', 'CT' => 'Connecticut', 'DC' => 'District of Columbia', 'DE' => 'Delaware', 'FM' => 'Federated States of Micronesia', 'FL' => 'Florida', 'GA' => 'Georgia', 'GU' => 'Guam', 'HI' => 'Hawaii', 'ID' => 'Idaho', 'IL' => 'Illinois', 'IN' => 'Indiana', 'IA' => 'Iowa', 'KS' => 'Kansas', 'KY' => 'Kentucky', 'LA' => 'Louisiana', 'ME' => 'Maine', 'MH' => 'Marshall Islands', 'MD' => 'Maryland', 'MA' => 'Massachusetts', 'MI' => 'Michigan', 'MN' => 'Minnesota', 'MS' => 'Mississippi', 'MO' => 'Missouri', 'MT' => 'Montana', 'MP' => 'Northern Mariana Islands', 'NE' => 'Nebraska', 'NV' => 'Nevada', 'NH' => 'New Hampshire', 'NJ' => 'New Jersey', 'NM' => 'New Mexico', 'NY' => 'New York', 'NC' => 'North Carolina', 'ND' => 'North Dakota', 'OH' => 'Ohio', 'OK' => 'Oklahoma', 'OR' => 'Oregon', 'PW' => 'Palau', 'PA' => 'Pennsylvania', 'PR' => 'Puerto Rico', 'RI' => 'Rhode Island', 'SC' => 'South Carolina', 'SD' => 'South Dakota', 'TN' => 'Tennessee', 'TX' => 'Texas', 'UT' => 'Utah', 'VT' => 'Vermont', 'VA' => 'Virginia', 'VI' => 'Virgin Islands', 'WA' => 'Washington', 'WV' => 'West Virginia', 'WI' => 'Wisconsin', 'WY' => 'Wyoming' }.with_indifferent_access


  # concerns # ---------------------------------------------------------------------------------------------------

  include Backbone
  include Geocoded


  # attributes # -------------------------------------------------------------------------------------------------

  backbone_attributes :id, :title, :line1, :line2, :city, :state, :zip, :country, :phone, :latitude, :longitude, :created_at, :updated_at


  # defaults # ---------------------------------------------------------------------------------------------------

  default_values country: 'USA'


  # normalization # ----------------------------------------------------------------------------------------------

  normalize_attribute :title,   with: [ :collapse, :propercase ]
  normalize_attribute :line1,   with: [ :collapse, :propercase ]
  normalize_attribute :line2,   with: [ :collapse, :propercase, :blank ]
  normalize_attribute :city,    with: [ :collapse, :propercase ]
  normalize_attribute :state,   with: [ :collapse, :upcase ]
  normalize_attribute :zip,     with: [ :zipcode ]
  normalize_attribute :country, with: [ :collapse, :upcase ]
  normalize_attribute :phone,   with: [ :phone ]


  # validations # ------------------------------------------------------------------------------------------------

  validates :addressable, presence: true
  validates :phone, phone: true, if: :phone
  validates :state, inclusion: { in: STATES.keys }, if: :state
  validates :zip, zipcode: true, if: :zip


  # relations # --------------------------------------------------------------------------------------------------

  belongs_to :addressable, polymorphic: true


  # callbacks # --------------------------------------------------------------------------------------------------




  # plugins # ----------------------------------------------------------------------------------------------------

  has_paper_trail


  public # -------------------------------------------------------------------------------------------------------

  def city_state_zip
    "#{city}, #{state} #{zip}"
  end

  def street_address
    line2.present? ? "#{line1} #{line2}" : line1
  end

  def location
    "#{line1}, #{city_state_zip}"
  end

  def state_name
    STATES[ state ]
  end

  def to_s
    "#{self.class} #{id} (#{location})"
  end

end
