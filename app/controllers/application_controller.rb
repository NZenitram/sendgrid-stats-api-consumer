class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  layout :layout

  def disable_nav
    @disable_nav = true
  end

  private

  def layout
    is_a?(DeviseController) ? false : "application"
  end
end
