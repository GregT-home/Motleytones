# frozen_string_literal: true

# Local override
dotenv = File.expand_path('../.env_overrides.rb', __FILE__)
require dotenv if File.exist?(dotenv)

ENV['RAILS_ENV'] ||= 'development'

ENV['DATABASE_ADAPTER'] ||= 'postgresql'
ENV['DATABASE_ENCODING'] ||= 'utf8'
ENV['DATABASE_POOL'] ||= '5'
ENV['DATABASE_TIMEOUT'] ||= '5000'

ENV['SECRET_KEY_BASE']  ||= 'define in .env-overrides.rb'
ENV['STARTER_PASSWORD'] ||= 'secretpw'

ENV['CODECLIMATE_API_HOST'] ||= 'https://codebeat.co/webhooks/code_coverage'
ENV['CODECLIMATE_REPO_TOKEN'] ||= 'define in .env-overrides.rb'

# Action Mailer values
ENV['SMTP_USER'] ||= 'define-in@overrides.rb'
ENV['SMTP_PASSWORD'] ||= 'bogus-pwd'
ENV['SMTP_DOMAIN'] ||= 'motleytones.com'
