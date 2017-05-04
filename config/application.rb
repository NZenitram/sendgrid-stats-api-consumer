require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SendgridStatsApiConsumer
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end

Rails.application.configure do

  config.action_mailer.perform_deliveries = true

  config.action_mailer.default_url_options = { host: 'ec2-52-52-82-101.us-west-1.compute.amazonaws.com' }

  config.action_mailer.delivery_method = :smtp

  config.active_job.queue_adapter = :delayed_job

end
