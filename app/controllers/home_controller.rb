class HomeController < ApplicationController

  def index
    @providers = Response.inbox_providers
  end

  def show

  end

  def search
    binding.pry
  end
end
