class Api::V1::ProvidersController < ApplicationController

  def show
    filename = params["slug"]
    @response = File.read("./tmp/#{filename}")
    render json: {thing: @response}
  end
end
