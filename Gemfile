source "https://rubygems.org"

# framework
gem "rails", "~> 8.0.2"

# server
gem "bootsnap", require: false
gem "puma", ">= 5.0"
gem "rack-cors"
gem "thruster", require: false

# database
gem "pg", "~> 1.1"
# gem "bcrypt", "~> 3.1.7"


# windows specific
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
# gem "kamal", require: false

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 7.0.0'

  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end
