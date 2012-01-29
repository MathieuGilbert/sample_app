class ApplicationController < ActionController::Base
  before_filter :set_asset_url

  def set_asset_url
    ActionController::Base.asset_host = "#{request.host}:#{request.port}/#{ENV['APP_ROOT_FOLDER']}"
  end
  
  protect_from_forgery
  # make this helper available in controllers (default only in views)
  include SessionsHelper

end
