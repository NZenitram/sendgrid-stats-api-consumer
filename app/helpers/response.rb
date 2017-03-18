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
    CSV.open("./tmp/#{file}", "wb") do |csv|
      csv << header
    end
    CSV.open("./tmp/#{global}", "wb") do |csv|
      csv << header
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
    header_values = ["blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    event_totals = []
    csv = CSV.read("./tmp/global_csv", :headers => true)
    header_values.each do |event|
      event_sum = csv[event].map do |i|
        i.to_i
      end.reduce(:+)
      event_totals << event_sum
    end
    CSV.open("./tmp/global_stats", 'wb', :headers => true) do |csv|
      csv << header_values
      csv << event_totals
    end
  end

end
