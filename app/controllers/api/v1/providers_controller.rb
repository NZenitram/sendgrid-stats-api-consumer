class Api::V1::ProvidersController < ApplicationController

  def show
    @response = File.read('./tmp/Hotmail')
    render json: {thing: @response}
  end
end
