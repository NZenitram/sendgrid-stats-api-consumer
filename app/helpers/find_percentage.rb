class FindPercentage
  def initialize(event, deliveries)
    @event = event
    @deliveries = deliveries
  end

  def percentage
    (@event / @deliveries).round(5) * 100
  end

  def self.not_a_number?(event)
    (event.is_a?(Float) && event.nan? || event == Float::INFINITY)
  end
end
