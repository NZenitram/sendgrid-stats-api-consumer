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
    header = ["date", "provider", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open("./tmp/#{file}", "wb") do |csv|
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
    CSV.open("./tmp/#{file}", "ab") do |csv|
      csv << clean_data
    end
  end

  def self.inbox_providers
    csv = CSV.read("./tmp/response_csv", :headers => true)
    inbox = csv['provider']
    email_providers = inbox.uniq
    ParsingProviders.parse_csv(email_providers)
  end
end
