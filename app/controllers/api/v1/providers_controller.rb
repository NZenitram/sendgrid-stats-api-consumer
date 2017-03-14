class Api::V1::ProvidersController < ApplicationController

  def show
    @provider = Response.testing(params[:slug])
    binding.pry
    render json: @provider, status: 200
  end
end
