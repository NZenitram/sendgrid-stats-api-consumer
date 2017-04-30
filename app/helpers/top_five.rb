require 'csv'

class TopFive
  def self.find_providers(id)
    uri = URI.parse("#{ENV['SENDGRID_STATS_DB_API']}/api/v1/top-five/#{id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
