# frozen_string_literal: true

source 'https://rubygems.org'

gem 'ahoy_matey', '~> 2.0'
gem 'bcrypt', '~> 3.1.22'
gem 'coffee-rails'
gem 'csv', '~> 3.0'
gem 'devise', '~> 4.6'
gem 'font-awesome-rails', '~> 4.4'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails', '~> 4.0'
gem 'net-http'             # needed until all the gems drop support for Ruby 2.5.5
gem 'pg', '~> 1.5'
gem 'puma', '> 6.0'
gem 'rails', '~> 7.2'
gem 'rubocop-rails', require: false  # CLI; no need to load this for normal operation.
gem 'sassc-rails'
gem 'simple_form', '~> 5.0'
gem 'slim-rails'
gem 'sprockets'
gem "terser", "~> 1.2"
gem 'turbolinks', '~> 5.0.0' # Read more: https://github.com/turbolinks/turbolinks

group :development, :test do
  gem 'awesome_print'
  gem 'database_cleaner', '~> 2.0' # upgrade this as separate card
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rescue'
  gem 'spring'
end

group :development do
  gem 'web-console' # console when exception or <%= console %> in views
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'selenium-webdriver', '~>4.23.0'
  gem 'simplecov', require: false
  gem 'spinach-rails'
end

ruby '3.3.5'

