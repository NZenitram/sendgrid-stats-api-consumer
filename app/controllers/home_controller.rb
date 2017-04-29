class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:providers, :topfive, :index, :search, :welcome]
  before_filter :disable_nav, only: [:welcome]

  def index
    @providers = Response.inbox_providers
  end

  def show

  end

  def search
    if params["datepicker-start"] == ""
      flash[:notice] = "Start Date Cannot Be Empty"
      redirect_to welcome_path
    else
      key = params["client-id"]
      id = current_user.id
      start_date = DateHelper.correct_date(params["datepicker-start"])
      end_date = DateHelper.correct_date(params["datepicker-end"])
      Response.gather_data(start_date, end_date, key, id)
      GlobalStats.gather_data(start_date, end_date, key, id)
      redirect_to global_path
    end
  end

  def providers
    @providers = Response.inbox_providers
  end

  def topfive
    @providers = TopFive.find_providers
  end
end
