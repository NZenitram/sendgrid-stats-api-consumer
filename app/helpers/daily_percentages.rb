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
    prov_percent = []
    table.each do |row|
      date = row["date"]
      delivered_events = row["delivered"].to_f
      open_events = row["opens"].to_f
      click_events = row["clicks"].to_f
      spam_events = row["spam_reports"].to_f
      open_percentage = FindPercentage.new(open_events, delivered_events).percentage
      click_percentage = FindPercentage.new(click_events, delivered_events).percentage
      spam_percentage = FindPercentage.new(spam_events, delivered_events).percentage
      prov_percent << date
      if (open_percentage.is_a?(Float) && open_percentage.nan?)
        prov_percent << 0.0
      else
        prov_percent << open_percentage.round(2)
      end
      if (click_percentage.is_a?(Float) && click_percentage.nan?)
        prov_percent << 0.0
      else
        prov_percent << click_percentage.round(2)
      end
      if (spam_percentage.is_a?(Float) && click_percentage.nan?)
        prov_percent << 0.0
      else
        prov_percent << spam_percentage.round(2)
      end
    end
    days = prov_percent.each_slice(4).to_a
    recreate_csv(table, title, days)
  end

  def self.recreate_csv(table, title, days)
    days.pop
    header = ["date", "opens", "clicks", "spam"]
    CSV.open("./tmp/#{title}_percent", 'wb', :headers => true) do |csv|
      csv << header
    end
    CSV.open("./tmp/#{title}_percent", 'ab', :headers => true) do |csv|
      days.each do |day|
        csv << day
      end
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
end
