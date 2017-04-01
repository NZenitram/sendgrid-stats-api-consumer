require 'csv'
module RollingFiveday
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
    CSV.open("./tmp/#{title}_fiveday", 'wb', :headers => true) do |csv|
      csv << header
    end
    CSV.open("./tmp/#{title}_fiveday", 'ab', :headers => true, converters: :integer) do |csv|
      matches.each do |row|
        csv << row
      end
    end
    delete_provider(title)
  end

  def self.delete_provider(title)
    table = CSV.read("./tmp/#{title}_fiveday", :headers => true, converters: :integer)
    table.delete('provider')
    separate_events(table, title)
  end

  def self.separate_events(table, title)
    header = ["date", "opens", "clicks", "spam"]
    CSV.open("./tmp/#{title}_fiveday", 'wb', :headers => true) do |csv|
      csv << header
    end
    table.each do |row|
      binding.pry
      date = row["date"]
      delivered_events = row["delivered"].to_f
      open_events = row["opens"].to_f
      click_events = row["clicks"].to_f
      spam_events = row["spam_reports"].to_f
      calculate_percentages(table, title, date, delivered_events, open_events, click_events, spam_events)
    end
  end
end
