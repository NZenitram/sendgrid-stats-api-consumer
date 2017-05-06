# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
<<<<<<< HEAD
=======

>>>>>>> 9b53da1... merge conflicts
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USER_NAME'],
  :password => ENV['SENDGRID_API_KEY'],
  :address => 'smtp.sendgrid.net',
  :domain => 'simplymailstatistics.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
