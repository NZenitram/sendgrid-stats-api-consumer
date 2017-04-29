class LandingController < ApplicationController
  before_action :authenticate_user!

  def index
    if !authenticate_user!.nil?
      redirect_to(welcome_path)
    end
  end
end
