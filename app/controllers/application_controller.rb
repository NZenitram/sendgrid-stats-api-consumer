class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout

  def disable_nav
    @disable_nav = true
  end

  private

  def layout
    # only turn it off for login pages:
    is_a?(DeviseController) ? false : "application"
    # is_a?(Devise::RegistrationsController) ? false : "application"
    # or turn layout off for every devise controller:
    # devise_controller? && "application"
  end
end
