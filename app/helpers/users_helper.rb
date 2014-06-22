module UsersHelper

  def user_id( user )
    user.id.try( :to_s ) || missing_field
  end

  def user_last_callsign( user )
    user.last_callsign || missing_field
  end

  def user_email( user )
    user.email || missing_field
  end

  def user_status( user )
    user.status.try( :titleize ) || missing_field
  end

  def user_sign_in_count( user )
    user.sign_in_count.try( :to_s ) || missing_field
  end

  def user_current_sign_in_at( user )
    user.current_sign_in_at.try( :strftime, '%c' ) || missing_field
  end

  def user_last_sign_in_at( user )
    user.last_sign_in_at.try( :strftime, '%c' ) || missing_field
  end

  def user_confirmed_at( user )
    user.confirmed_at.try( :strftime, '%c' ) || missing_field
  end

  def user_confirmation_sent_at( user )
    user.confirmation_sent_at.try( :strftime, '%c' ) || missing_field
  end

  def user_locked_at( user )
    user.locked_at.try( :strftime, '%c' ) || missing_field
  end

  def user_created_at( user )
    user.created_at.try( :strftime, '%c' ) || missing_field
  end

end
