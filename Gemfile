# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'active_model_serializers'
gem 'bcrypt'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails'
gem 'jquery-rails'
gem 'pg'
gem 'pry-rails'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'uglifier'
# gem 'sidekiq'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'with_advisory_lock'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubocop-config-umbrellio'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'activerecord-import'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
