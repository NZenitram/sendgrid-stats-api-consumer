module DateHelper

  def self.correct_date(date)
    date_array = date.split('/')
    year = date_array.pop
    new_date = date_array.unshift(year)
    new_date.join('-')
  end

end
