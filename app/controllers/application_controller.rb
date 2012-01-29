class ApplicationController < ActionController::Base
  protect_from_forgery
  # make this helper available in controllers (default only in views)
  include SessionsHelper

end
