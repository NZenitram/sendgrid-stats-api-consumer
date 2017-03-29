require 'csv'
module DailyPercentages
  def self.parse_csv
    Response.inbox_providers.each do |provider|
      title = provider
      search_criteria = {"provider" => title}
      CSV.open("./tmp/response_csv", "r", :headers => true) do |csv|
        matches = csv.find_all do |row|
          match = true
          search_criteria.keys.each do |key|
            match = match && ( row[key] == search_criteria[key])
          end
          match
        end
        save_provider(matches, title)
      end
    end
  end

  def self.save_provider(matches, bad_title)
    title = bad_title.delete('&''.'' ')
    header = ["date", "provider", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open("./tmp/#{title}_percent", 'wb', :headers => true) do |csv|
      csv << header
    end
    CSV.open("./tmp/#{title}_percent", 'ab', :headers => true, converters: :integer) do |csv|
      matches.each do |row|
        csv << row
      end
    end
    delete_provider(title)
  end

  def self.delete_provider(title)
    table = CSV.read("./tmp/#{title}_percent", :headers => true, converters: :integer)
    table.delete('provider')
    separate_events(table, title)
  end

  def self.separate_events(table, title)
    header = ["date", "opens", "clicks", "spam"]
    CSV.open("./tmp/#{title}_percent", 'wb', :headers => true) do |csv|
      csv << header
    end
    table.each do |row|
      date = row["date"]
      delivered_events = row["delivered"].to_f
      open_events = row["opens"].to_f
      click_events = row["clicks"].to_f
      spam_events = row["spam_reports"].to_f
      calculate_percentages(table, title, date, delivered_events, open_events, click_events, spam_events)
    end
  end

  def self.calculate_percentages(table, title, date, delivered_events, open_events, click_events, spam_events)
      prov_percent = []
      open_percentage = FindPercentage.new(open_events, delivered_events).percentage
      click_percentage = FindPercentage.new(click_events, delivered_events).percentage
      spam_percentage = FindPercentage.new(spam_events, delivered_events).percentage
      prov_percent << date
      if FindPercentage.not_a_number?(open_percentage)
        prov_percent << 0.0
      else
        prov_percent << open_percentage.round(2)
      end
      if FindPercentage.not_a_number?(click_percentage)
        prov_percent << 0.0
      else
        prov_percent << click_percentage.round(2)
      end
      if FindPercentage.not_a_number?(spam_percentage)
        prov_percent << 0.0
      else
        prov_percent << spam_percentage.round(2)
      end
    recreate_csv(table, title, prov_percent)
  end

  def self.recreate_csv(table, title, prov_percent)
    CSV.open("./tmp/#{title}_percent", 'ab', :headers => true) do |csv|
        csv << prov_percent
    end
  end
end

class FindPercentage
  def initialize(event, deliveries)
    @event = event
    @deliveries = deliveries
  end

  def percentage
    (@event / @deliveries).round(5) * 100
  end

  def self.not_a_number?(event)
    (event.is_a?(Float) && event.nan? || event == Float::INFINITY)
  end
end
