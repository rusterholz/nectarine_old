module ContactsHelper

  def contact_columns
    {
      id:           'ID',
      first_name:   'First',
      last_name:    'Last',
      birthdate:    'DOB',
      age:          'Age',
      gender:       'Gender',
      ethnicity:    'Ethnicity',
      description:  'Description'
    }
  end

  def contact_id( contact )
    contact.id.try( :to_s ) || missing_field
  end

  def contact_first_name( contact )
    contact.first_name || missing_field
  end

  def contact_last_name( contact )
    contact.last_name || missing_field
  end

  def contact_birthdate( contact )
    contact.birthdate.try( :strftime, '%b %-d %Y' ) || missing_field
  end

  def contact_age( contact )
    contact.age ? contact.age.to_i.to_s : missing_field
  end

  def contact_gender( contact )
    contact.gender.try( :upcase ) || missing_field
  end

  def contact_ethnicity( contact )
    contact.ethnicity.try( :titlecase ) || missing_field
  end

  def contact_description( contact )
    contact.description.try( :collapse ) || missing_field
  end

  # def contact_contactable( contact )
  #   contact.contactable ? contact.contactable.to_s : missing_field
  # end


end

