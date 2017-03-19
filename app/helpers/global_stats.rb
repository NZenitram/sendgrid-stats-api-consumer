class GlobalStats
  def self.sum_global_events_with_same_date
    header = ["date", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open("./tmp/global_without_dates", "wb", :headers => true) do |csv|
      csv << header
    end
    create_array_of_unique_dates
  end

  def self.create_array_of_unique_dates
    csv = CSV.read("./tmp/response_csv", :headers => true)
    dates_all = csv['date']
    dates = dates_all.uniq
    csv_search_criteria(dates)
  end

  def self.csv_search_criteria(dates)
    dates.each do |date|
      search_criteria = {"date" => date}
      open_csv_and_set_matches(search_criteria, date)
    end
  end

  def self.open_csv_and_set_matches(search_criteria, date)
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
