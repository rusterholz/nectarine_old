class Contact < ActiveRecord::Base

  include Backbone

  backbone_attributes :id, :first_name, :last_name, :birthdate, :age, :gender, :ethnicity, :description

end
