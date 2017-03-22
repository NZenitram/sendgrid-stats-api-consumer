class Api::V1::ProvidersController < ApplicationController

  def show
    filename = params["slug"]
    @response = File.read("./tmp/#{filename}")
    render json: {thing: @response}
  end

  def percentage
    @percentage_hash = ProviderPercentages.reduce_events
    render json: @percentage_hash
  end

end
