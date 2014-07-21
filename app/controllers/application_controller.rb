class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Browser
  include Parameters

  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_url, alert: e.message # this can probably be improved upon later
  end

  # prevent Paloma from firing on JSON requests
  before_action :no_paloma_on_json
  def no_paloma_on_json
    js false if request.format.to_s.split('/').last == 'json'
  end

end
