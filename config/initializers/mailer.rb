ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USER_NAME'],
  :password => ENV['SENDGRID_API_KEY'],
  :domain => 'www.simplymailstatistics.com',
  :address => 'smtp.sendgrid.net',
  :port => 465,
  :authentication => :plain,
  :enable_starttls_auto => true
}
