class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def disable_nav
    @disable_nav = true
  end
end
