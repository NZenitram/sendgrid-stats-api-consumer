require 'csv'

module ProviderPercentages
  def self.select_provider_csv
    title = Response.inbox_providers.map do |bad_title|
      bad_title.delete('&''.'' ')
    end
  end

  def self.reduce_events
    providers_hash = {}
    event_types = ["spam", "open_percentage", "click_percentage", "unique_opens_percentage", "unique_clicks_percentage"]
    title = ProviderPercentages.select_provider_csv
     title.each do |title|
      provider_data = CSV.read("./tmp/#{title}", headers: true, converters: :integer)
      total_delivered = provider_data["delivered"].reduce(:+).to_f
      total_clicks = provider_data["clicks"].reduce(:+).to_f
      total_opens = provider_data["opens"].reduce(:+).to_f
      total_spam_reports = provider_data["spam_reports"].reduce(:+).to_f
      total_unique_clicks = provider_data["unique_clicks"].reduce(:+).to_f
      total_unique_opens = provider_data["unique_opens"].reduce(:+).to_f
      spam = (total_spam_reports / total_delivered).round(5) * 100
      opens = (total_opens / total_delivered).round(5) * 100
      clicks = (total_clicks / total_delivered).round(5) * 100
      unique_opens = (total_unique_opens / total_delivered).round(5) * 100
      unique_clicks = (total_unique_clicks / total_delivered).round(5) * 100
      event_percentages = [spam, opens, clicks, unique_opens, unique_clicks]
      hash = Hash[event_types.zip event_percentages]
      providers_hash.merge!(title => hash)
    end
    providers_hash
  end

  def self.single_provider_percentages(percentage_hash, provider)
    percentage_hash.fetch(provider)
  end
end
