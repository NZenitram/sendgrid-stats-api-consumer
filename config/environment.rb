# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgrid.net',
  :port => '465',
  :domain => 'www.simplymailstatistics.com',
  :user_name => ENV['SENDGRID_USER_NAME'],
  :password => ENV['SENDGRID_API_KEY'],
  :authentication => :plain,
  :enable_starttls_auto => true,
  ssl:                   true,
  tls:                   true
}
