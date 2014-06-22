class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Browser
  include Parameters

  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_url, alert: e.message # this can probably be improved upon later
  end

end
