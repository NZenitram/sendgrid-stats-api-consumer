require 'csv'
module RollingFiveday
  def self.get_providers
    providers = Response.inbox_providers
    read_provider_percentage_csv(providers)
  end

  def self.read_provider_percentage_csv(providers)
    providers.each do |provider|
      provider_csv = CSV.read("./tmp/#{provider}_percent", :headers => true, converters: :integer)
      
    end
  end
end
