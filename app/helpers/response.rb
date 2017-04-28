require "net/http"
require "uri"

module Response

  def self.response(start_date, end_date, key)
    conn = Faraday::Connection.new("https://api.sendgrid.com/v3/mailbox_providers/stats?start_date=#{start_date}&end_date=#{end_date}")
    conn.headers['Authorization'] = "Bearer #{key}"
    parse_reponse(conn)
  end

  def self.parse_reponse(conn)
    response = conn.get
    providers = JSON.parse(response.body, symbolize_names: true)
  end

  def self.gather_data(start_date, end_date, key, id)
    providers = response(start_date, end_date, key)
    @data = []
    if !providers.empty?
      providers.each do |metric|
        metric[:stats].each do |i|
          provider = Provider.new(metric[:date], i[:name],
                                  i[:metrics].values[0], i[:metrics].values[1],
                                  i[:metrics].values[2], i[:metrics].values[3],
                                  i[:metrics].values[4], i[:metrics].values[5],
                                  i[:metrics].values[6], i[:metrics].values[7],
                                  i[:metrics].values[8], i[:metrics].values[9],
                                  id)
          @data.push(provider)
        end
      end
      json = @data.to_json
      uri = URI.parse("#{ENV['SENDGRID_STATS_DB_API']}/api/v1/providers")
      response = Net::HTTP.post_form(uri, { "providers" => "#{json}" })
    end
  end

  def self.inbox_providers
    uri = URI.parse("#{ENV['SENDGRID_STATS_DB_API']}/api/v1/providers-names")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
