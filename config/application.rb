require_relative '../env' # define general default values
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Motleytones
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Configure Action Mailer
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default :charset => 'utf-8'

    ActionMailer::Base.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      authentication: :plain,
      domain: ENV['SMTP_DOMAIN'],
      user_name: ENV['SMTP_USER'],
      password: ENV['SMTP_PASSWORD'],
    }
  end
end
