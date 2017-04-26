require "net/http"
require "uri"

class GlobalStats
  def self.get_global_data(start_date, end_date, key)
    conn = Faraday::Connection.new("https://api.sendgrid.com/v3/stats?start_date=#{start_date}&end_date=#{end_date}")
    conn.headers['Authorization'] = "Bearer #{key}"
    parse_response(conn)
  end

  def self.parse_response(conn)
    response = conn.get
    dates_object = JSON.parse(response.body, symbolize_names: true)
    gather_data(dates_object)
  end

  def self.gather_data(dates_object)
    @data = []
    dates_object.each do |date|
      metrics = date[:stats][0][:metrics]
        global = Global.new(date[:date], metrics[:blocks],
                            metrics[:bounce_drops], metrics[:bounces],
                            metrics[:clicks], metrics[:deferred],
                            metrics[:delivered], metrics[:invalid_emails],
                            metrics[:opens],
                            metrics[:processed], metrics[:requests],
                            metrics[:spam_report_drops], metrics[:spam_reports],
                            metrics[:unique_clicks], metrics[:unique_opens],
                            metrics[:unsubscribe_drops], metrics[:unsubscribes],
                             1)
    @data.push(global)
    end
    json = @data.to_json
    uri = URI.parse("#{ENV['SENDGRID_STATS_DB_API']}/api/v1/global-stats")
    response = Net::HTTP.post_form(uri, { "globals" => "#{json}" })

  end
end
