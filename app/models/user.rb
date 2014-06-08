class User < ActiveRecord::Base

  PIT_EMAIL =     'pit@nectarine.nil'
  PIT_PASSWORD =  'nectarine'
  
  devise :confirmable, :database_authenticatable, :encryptable, :lockable, :recoverable, :registerable, :rememberable, :timeoutable, :trackable, :validatable

  has_paper_trail ignore: %i( current_sign_in_at current_sign_in_ip failed_attempts last_sign_in_at last_sign_in_ip sign_in_count )

  default_values status: 'active'

  def self.pit
    where( email: PIT_EMAIL ).first || (
      pit = create!( email: PIT_EMAIL, password: PIT_PASSWORD, password_confirmation: PIT_PASSWORD )
      pit.confirm! && pit.reload
    )
  end

end
