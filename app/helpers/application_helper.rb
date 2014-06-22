module ApplicationHelper

  # Easy non-breaking space macro.
  def nbsp( arg = 1 )
    ( String === arg ? arg.gsub( ' ', '&nbsp;' ) : '&nbsp;' * arg ).html_safe
  end

  # Easy m-dash macro.
  def mdash( arg = 1 )
    ( '&mdash;' * arg ).html_safe
  end

  # Macro for when there's no value present for a data field.
  def missing_field( err = 'none', color: '#d2d2d2' )
    "<em style='color: #{color};'>(#{err})</em>".html_safe
  end

  def app_name
    Rails.application.class.to_s.split('::').first.titleize
  end

  def google_font_stylesheet_tag( font_name, styles: ['400'], ssl: false, turbolinks: true )
    stylesheet_link_tag( "http#{ssl ? 's' : ''}://fonts.googleapis.com/css?family=#{font_name.collapse.gsub( / /, '+' )}:#{styles.join(',')}", media: 'all', 'data-turbolinks-track' => !!turbolinks )
  end

  def flash_key_alert_classes
    {
      alert:    'alert-warning',
      error:    'alert-danger',
      notice:   'alert-info',
      success:  'alert-success'
    }
  end

  def user_identification
    # current_user ? ( current_user.last_callsign.present? ? user_last_callsign( current_user ) : user_email( current_user ) ) : '(not signed in)'
    current_user ? user_email( current_user ) : '(not signed in)'
  end

  def articleize( string, article: :indefinite )
    { definite: "the #{string}", indefinite: "a#{/^[aeiou]/i.match(string) && 'n'} #{string}" }[ article ]
  end

end
