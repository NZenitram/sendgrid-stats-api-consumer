class Provider
  attr_accessor :date, :provider_name, :blocks, :bounce, :clicks, :deferred, :drops, :opens, :spam_reports, :unique_clicks, :unique_opens, :user_id

  def initialize(date, provider_name, blocks, bounces, clicks, deferred, delivered, drops, opens, spam_reports, unique_clicks, unique_opens, user_id)
    @date =  date
    @provider_name = provider_name
    @blocks = blocks
    @bounces = bounces
    @clicks = clicks
    @deferred = deferred
    @delivered = delivered
    @drops = drops
    @opens = opens
    @spam_reports = spam_reports
    @unique_clicks = unique_clicks
    @unique_opens = unique_opens
    @user_id = user_id
  end
end
