# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'apollo_upload_server'
gem 'bootsnap', require: false
gem 'dotenv-rails'
gem 'graphql'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'search_object'
gem 'search_object_graphql'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'action_policy'
gem 'action_policy-graphql'

group :development, :test do
  gem 'awesome_print'
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'strong_migrations'
  gem 'simplecov'
end

group :test do
  gem 'shoulda-matchers'
  gem 'test-prof'
end
