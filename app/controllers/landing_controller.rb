class LandingController < ApplicationController
  before_action :authenticate_user!
  before_action :disable_nav

  def index
    if !authenticate_user!.nil?
      redirect_to(welcome_path)
    end
  end
end
