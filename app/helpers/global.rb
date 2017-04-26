class Global
  attr_accessor :date, :blocks, :bounce_drops, :bounces, :clicks, :deferred, :delivered, :opens, :invalid_emails, :processed, :requests, :spam_report_drops, :spam_reports, :unique_clicks, :unique_opens, :unsubscribe_drops, :unsubscribes, :user_id

  def initialize(date, blocks, bounce_drops, bounces, clicks, deferred, delivered, opens, invalid_emails, processed, requests, spam_report_drops, spam_reports, unique_clicks, unique_opens, unsubscribe_drops, unsubscribes, user_id)
    @date = date
    @blocks = blocks
    @bounce_drops = bounce_drops
    @bounces = bounces
    @clicks = clicks
    @deferred = deferred
    @delivered = delivered
    @invalid_emails = invalid_emails
    @opens = opens
    @processed = processed
    @requests = requests
    @spam_report_drops = spam_report_drops
    @spam_reports = spam_reports
    @unique_clicks = unique_clicks
    @unique_opens = unique_opens
    @unsubscribe_drops = unsubscribe_drops
    @unsubscribes = unsubscribes
    @user_id = user_id
  end
end
