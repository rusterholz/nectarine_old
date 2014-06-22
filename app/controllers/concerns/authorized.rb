module Authorized
  extend ActiveSupport::Concern

  included do
    check_authorization
    load_and_authorize_resource
  end

end


