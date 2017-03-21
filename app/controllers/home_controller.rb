class HomeController < ApplicationController
  before_filter :disable_nav, only: [:welcome]

  def index
    @providers = Response.inbox_providers
  end

  def show

  end

  def search
    key = params["client-id"]
    start_date = DateHelper.correct_date(params["datepicker-start"])
    end_date = DateHelper.correct_date(params["datepicker-end"])
    Response.response(start_date, end_date, key)
    GlobalStats.get_global_data(start_date, end_date, key)
    redirect_to root_path
  end
end
