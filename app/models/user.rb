class User < ActiveRecord::Base

  # constants # --------------------------------------------------------------------------------------------------

  PIT_EMAIL =     'pit@nectarine.nil'
  PIT_PASSWORD =  'nectarine'


  # concerns # ---------------------------------------------------------------------------------------------------


  # attributes # -------------------------------------------------------------------------------------------------


  # defaults # ---------------------------------------------------------------------------------------------------

  default_values status: 'active'


  # normalization # ----------------------------------------------------------------------------------------------

  normalize_attribute :last_callsign, with: [ :collapse, :downcase, :blank ]


  # validations # ------------------------------------------------------------------------------------------------


  # relations # --------------------------------------------------------------------------------------------------


  # callbacks # --------------------------------------------------------------------------------------------------


  # plugins # ----------------------------------------------------------------------------------------------------

  devise :async, :confirmable, :database_authenticatable, :encryptable, :lockable, :recoverable, :registerable, :rememberable, :timeoutable, :trackable, :validatable

  has_paper_trail ignore: %i( current_sign_in_at current_sign_in_ip failed_attempts last_sign_in_at last_sign_in_ip sign_in_count )

  state_machine :status do
    state :active
    state :disabled
    event :disable do
      transition active: :disabled
    end
    event :activate do
      transition disabled: :active
    end
  end


  public # -------------------------------------------------------------------------------------------------------

  def self.pit
    where( email: PIT_EMAIL ).first || (
      pit = create!( email: PIT_EMAIL, password: PIT_PASSWORD, password_confirmation: PIT_PASSWORD )
      pit.confirm! && pit.reload
    )
  end

  def to_s
    "#{self.class} #{id}"
  end

end
