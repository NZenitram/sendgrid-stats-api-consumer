require 'csv'

module ParsingProviders
  def self.parse_csv(email_providers)
    email_providers.each do |provider|
      title = provider.titleize
      search_criteria = {"provider" => title}
      CSV.open("./tmp/response_csv", "r", :headers => true) do |csv|
        matches = csv.find_all do |row|
          match = true
          search_criteria.keys.each do |key|
            match = match && ( row[key] == search_criteria[key])
          end
          match
        end
        save_provider(matches, title)
      end
    end
  end

  def self.save_provider(matches, title)
    header = ["date", "provider", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]
    CSV.open("./tmp/#{title}", 'wb', :headers => true) do |csv|
      csv << header
    end
    CSV.open("./tmp/#{title}", 'ab', :headers => true) do |csv|
      matches.each do |row|
        csv << row
      end
    end
    delete_provider(title)
  end

  def self.delete_provider(title)
    table = CSV.read("./tmp/#{title}", :headers => true)
    table.delete('provider')
    recreate_csv(table, title)
  end

  def self.recreate_csv(table, title)
    header = ["date", "blocks", "bounces", "clicks", "deferred", "delivered", "drops", "opens", "spam_reports", "unique_clicks", "unique_opens"]

    CSV.open("./tmp/#{title}", 'wb', :headers => true) do |csv|
      csv << header
    end

    CSV.open("./tmp/#{title}", 'ab', :headers => true) do |csv|
      table.each do |row|
        csv << row
      end
    end
  end
end
