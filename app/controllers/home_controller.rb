class HomeController < ApplicationController

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
  end
end
