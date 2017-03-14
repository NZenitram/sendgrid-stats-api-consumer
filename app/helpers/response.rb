require 'csv'

module Response

  def self.response
    conn = Faraday::Connection.new("https://api.sendgrid.com/v3/mailbox_providers/stats?start_date=2016-01-01&end_date=2017-03-03")
    conn.headers['Authorization'] = "Bearer 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"
    parse_reponse(conn)
  end

  def self.parse_reponse(conn)
    response = conn.get
    providers = JSON.parse(response.body, symbolize_names: true)
    create_header(providers)
  end

  def self.create_header(providers)
    file = "XYZ"
    header = ["date", "provider", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open(file, "wb") do |csv|
      csv << header
    end
    gather_data(providers, file)
  end

  def self.gather_data(providers, file)
    providers.each do |metric|
      metric[:stats].each do |i|
        data = []
        data.push(metric[:date])
        data.push(i[:name])
        data.push(i[:metrics].values)
        clean_data = data.flatten
        append_csv(clean_data, file)
      end
    end
  end

  def self.append_csv(clean_data, file)
    CSV.open(file, "ab") do |csv|
      csv << clean_data
    end
  end

  
end
