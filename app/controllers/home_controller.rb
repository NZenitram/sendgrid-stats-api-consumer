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
    ParsingProviders.parse_csv
    DailyPercentages.parse_csv
    redirect_to global_path
  end

  def providers
    @providers = Response.inbox_providers
  end

  def topfive
    @providers = TopFive.find_providers
  end
end
