# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.0'

gem 'rake'

# http layer
gem 'hanami', '1.3.0'
gem 'puma', '~> 3.11.0'

# persistance layer
gem 'hanami-model', '~> 1.3'
gem 'pg'

# dependency managment
gem 'dry-system', '~> 0.9.0'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'

# Monitoring and logging
gem 'semantic_logger'

# business logic section
gem 'dry-monads', '~> 1.1.0'

# templates
gem 'slim'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  # data generation and cleanup
  gem 'database_cleaner'
  gem 'hanami-fabrication'

  # style check
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'rspec-hanami'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

group :production do
  # gem 'puma'
end