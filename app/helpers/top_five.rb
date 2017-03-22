require 'csv'

class TopFive
  def self.find_providers
    data = CSV.read('./tmp/response_csv', :headers => true, :converters => :integer)
    sorted_by_deliveries = data.sort_by {|row| row["delivered"]}.reverse
    top_five = {}
    sorted_by_deliveries.each do |row|
      values = {row[1] => row[6]}
      if top_five.keys.include?(row[1])
        next
      else
        top_five.merge!(values)
      end
    end
    top_five.keys.first(5)
  end
end
