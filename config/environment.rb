# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "apikey",
  :password => "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",
  :address => 'smtp.sendgrid.net',
  :domain => 'simplymailstatistics.com'
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
