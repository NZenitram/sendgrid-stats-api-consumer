class Api::V1::ProvidersController < ApplicationController

  def show
    filename = params["slug"]
    @response = File.read("./tmp/#{filename}")
    render json: {thing: @response}
  end

  def percentage
    percentage_hash = ProviderPercentages.reduce_events.first
    @provider_percentages = ProviderPercentages.single_provider_percentages(percentage_hash, params["provider"])
    render json: {events: @provider_percentages}
  end

end
