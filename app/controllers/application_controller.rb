class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :unless => :devise_controller?
  protect_from_forgery with: :exception

  def disable_nav
    @disable_nav = true
  end

  def after_sign_in_path_for(resource)
    landing_path
  end

end
