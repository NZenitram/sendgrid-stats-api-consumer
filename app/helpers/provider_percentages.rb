require 'csv'

module ProviderPercentages

  def self.get_providers
    csv = CSV.read("./tmp/response_csv", :headers => true)
    get_unique_providers(csv)
  end

  def self.get_unique_providers(csv)
    inbox = csv['provider']
    email_providers = inbox.uniq
    select_provider_csv(email_providers)
  end

  def self.select_provider_csv(email_providers)
    title = email_providers.map do |bad_title|
      bad_title.delete('&''.'' ')
    end
  end

  def self.reduce_events
    providers_hash = {}
    title = ProviderPercentages.get_providers
    title.map do |title|
      provider_data = CSV.read("./tmp/#{title}", headers: true, converters: :integer)
      total_delivered = provider_data["delivered"].reduce(:+).to_f
      total_clicks = provider_data["clicks"].reduce(:+).to_f
      total_opens = provider_data["opens"].reduce(:+).to_f
      total_spam_reports = provider_data["spam_reports"].reduce(:+).to_f
      total_unique_clicks = provider_data["unique_clicks"].reduce(:+).to_f
      total_unique_opens = provider_data["unique_opens"].reduce(:+).to_f
      find_percentages(title, total_delivered, total_clicks, total_opens, total_spam_reports, total_unique_clicks, total_unique_opens, providers_hash)
    end
  end

  def self.find_percentages(title, total_delivered, total_clicks, total_opens, total_spam_reports, total_unique_clicks, total_unique_opens, providers_hash)
    spam_percentage = (total_spam_reports / total_delivered).round(5) * 100
    open_percentage = (total_opens / total_delivered).round(5) * 100
    click_percentage = (total_clicks / total_delivered).round(5) * 100
    unique_opens_percentage = (total_unique_opens / total_delivered).round(5) * 100
    unique_clicks_percentage = (total_unique_clicks / total_delivered).round(5) * 100
    write_percentage_csv(title, spam_percentage, open_percentage, click_percentage, unique_opens_percentage, unique_clicks_percentage, providers_hash)
  end

  def self.write_percentage_csv(title, spam, opens, click, unique_opens, unique_clicks, providers_hash)
    event_types = ["spam", "open_percentage", "click_percentage", "unique_opens_percentage", "unique_clicks_percentage"]
    event_percentages = [spam, opens, click, unique_opens, unique_clicks]
    create_providers_hash(title, event_types, event_percentages, providers_hash)
  end

  def self.create_providers_hash(title, event_types, event_percentages, providers_hash)
    hash = Hash[event_types.zip event_percentages]
    providers_hash.merge!(title => hash)
  end

  def self.single_provider_percentages(percentage_hash, provider)
    percentage_hash.fetch(provider)
  end
end
