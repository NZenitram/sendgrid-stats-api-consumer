require 'csv'

module Response

  def self.response(start_date, end_date, key)
    conn = Faraday::Connection.new("https://api.sendgrid.com/v3/mailbox_providers/stats?start_date=#{start_date}&end_date=#{end_date}")
    conn.headers['Authorization'] = "Bearer #{key}"
    parse_reponse(conn)
  end

  def self.parse_reponse(conn)
    response = conn.get
    providers = JSON.parse(response.body, symbolize_names: true)
    create_header(providers)
  end

  def self.create_header(providers)
    file = "response_csv"
    global = "global_csv"
    header = ["date", "provider", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    global_header = ["date", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open("./tmp/#{file}", "wb") do |csv|
      csv << header
    end
    CSV.open("./tmp/#{global}", "wb") do |csv|
      csv << global_header
    end
    gather_data(providers, file, global)
  end

  def self.gather_data(providers, file, global)
    providers.each do |metric|
      metric[:stats].each do |i|
        data = []
        data.push(metric[:date])
        data.push(i[:name])
        data.push(i[:metrics].values)
        clean_data = data.flatten
        append_csv(clean_data, file)
        append_global(clean_data, global)
      end
    end
  end

  def self.append_csv(clean_data, file)
    CSV.open("./tmp/#{file}", "ab") do |csv|
      csv << clean_data
    end
  end

  def self.append_global(data, global)
    clean_data = data.delete_at(1)
    CSV.open("./tmp/#{global}", "ab") do |csv|
      csv << data
    end
  end

  def self.inbox_providers
    csv = CSV.read("./tmp/response_csv", :headers => true)
    inbox = csv['provider']
    email_providers = inbox.uniq
    ParsingProviders.parse_csv(email_providers)
  end

  def self.reduce_global
    header = ["date", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open("./tmp/global_without_dates", "wb", :headers => true) do |csv|
      csv << header
    end
    header_values = ["blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    event_totals = []
    csv = CSV.read("./tmp/global_csv", :headers => true)
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
