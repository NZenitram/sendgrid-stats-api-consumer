class Api::V1::ProvidersController < ApplicationController

  def show
    @provider = Response.to_json(params[:slug])
    render json: @exercises, status: 200
  end
end
