

class GlobalStats
  def self.get_global_data(start_date, end_date, key)
    conn = Faraday::Connection.new("https://api.sendgrid.com/v3/stats?start_date=#{start_date}&end_date=#{end_date}")
    conn.headers['Authorization'] = "Bearer #{key}"
    parse_response(conn)
  end

  def self.parse_response(conn)
    response = conn.get
    dates_object = JSON.parse(response.body, symbolize_names: true)
    create_global_stats_csv(dates_object)
  end

  def self.create_global_stats_csv(dates_object)
    file = "global_data"
    header = ["date", "blocks", "bounce_drops", "bounces", "clicks", "deferred", "delivered", "invalid_emails", "opens", "processed", "requests", "spam_report_drops", "spam_reports", "unique_clicks", "unique_opens", "unsubscribe_drops", "unsubscribes"]
    CSV.open("./tmp/#{file}", "wb") do |csv|
      csv << header
    end
    gather_data(dates_object, file)
  end

  def self.gather_data(dates_object, file)
    dates_object.each do |date|
      date.each do |i|
      data = []
      data.push(date[:date])
      data.push(date[:stats].first[:metrics].values)
      clean_data = data.flatten
      append_csv(clean_data, file)
      end
    end
  end

  def self.append_csv(clean_data, file)
    CSV.open("./tmp/#{file}", "ab") do |csv|
      csv << clean_data
    end
  end

end
