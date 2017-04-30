require "net/http"
require "uri"

module Destroy
  def self.destroy_user_data(id)
    uri = URI.parse("#{ENV['SENDGRID_STATS_DB_API']}/api/v1/providers-destroy/#{id}")
    Net::HTTP.get(uri)
  end
end
