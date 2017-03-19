class GlobalStats
  def self.reduce_global
    header = ["date", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open("./tmp/global_without_dates", "wb", :headers => true) do |csv|
      csv << header
    end
    header_values = ["blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    event_totals = []
    csv = CSV.read("./tmp/response_csv", :headers => true)
    dates_all = csv['date']
    dates = dates_all.uniq
    dates.each do |date|
      search_criteria = {"date" => date}
      CSV.open("./tmp/response_csv", "r", :headers => true) do |csv|
        matches = csv.find_all do |row|
          match = true
          search_criteria.keys.each do |key|
            match = match && ( row[key] == search_criteria[key])
          end
          match
        end
        collect_event_totals(matches, date)
      end
    end
  end

  def self.collect_event_totals(matches, date)
    events = ["blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    event_hash = {}
    matches.each do |match|
      events.each do |event|
        event_integer = match[event].to_i
        if event_hash.keys.include?(event) == false
          event_hash[event] = [event_integer]
        else
          event_hash[event] << event_integer
        end
      end
    end
    sum_event_totals(event_hash, date)
  end

  def self.sum_event_totals(event_hash, date)
    daily_event = [date]
    event_hash.each do |event, count|
      event_count = count.reduce(:+)
      daily_event << event_count
    end
    CSV.open('./tmp/global_without_dates', 'ab', :headers => true) do |csv|
      csv << daily_event
    end
  end
end
