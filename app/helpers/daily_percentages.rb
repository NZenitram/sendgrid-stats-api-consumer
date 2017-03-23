require 'csv'
module DailyPercentages

  def self.get_providers
    csv = CSV.read("./tmp/response_csv", :headers => true)
    inbox = csv['provider']
    email_providers = inbox.uniq
    parse_csv(email_providers)
  end

  def self.parse_csv(email_providers)
    email_providers.each do |provider|
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
      open_percentage = (open_events / delivered_events).round(5) * 100
      click_percentage = (click_events / delivered_events).round(5) * 100
      spam_percentage = (spam_events / delivered_events).round(5) * 100
      prov_percent << date
      prov_percent << delivered_events
      prov_percent << open_percentage.round(2)
      prov_percent << click_percentage.round(2)
      prov_percent << spam_percentage.round(2)
    end
    days = prov_percent.each_slice(5).to_a
    recreate_csv(table, title, days)
  end

  def self.recreate_csv(table, title, days)
    header = ["date", "delivered", "opens", "clicks", "spam"]
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
