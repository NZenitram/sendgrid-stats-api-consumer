# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USER_NAME'],
  :password => ENV['SENDGRID_API_KEY'],
  :address => 'smtp.sendgrid.net',
  :port => 465,
  :domain => 'www.simplymailstatistics.com',
  :authentication => :plain,
  :enable_starttls_auto => true,
  ssl:                   true,
  tls:                   true
}
