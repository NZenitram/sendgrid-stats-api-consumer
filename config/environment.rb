# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['AWS_SMTP_USERNAME'],
  :password => ENV['AWS_SMTP_PASSWORD'],
  :address => ENV['AWS_SMTP'],
  :domain => 'simplymailstatistics.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
