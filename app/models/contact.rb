class Contact < ActiveRecord::Base

  include Medulla

  medulla_attributes :id, :first_name, :last_name, :birthdate, :age, :gender, :ethnicity, :description

end
