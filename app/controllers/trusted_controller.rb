class TrustedController < ApplicationController

  include Authenticated
  include Authorized

end