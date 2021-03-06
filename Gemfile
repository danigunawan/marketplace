# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "rails", "~> 5.2.0"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"

gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "webpacker"
gem "haml-rails"
gem "turbolinks", "~> 5", require: false

gem "bootsnap", ">= 1.1.0", require: false
gem "colorize", ">= 0.8.1", require: false

gem "ancestry"
gem "gretel"
gem "will_paginate", "~> 3.1.0"
gem "will_paginate-bootstrap4"
gem "simple_form"

# validation
gem "valid_email2"

gem "elasticsearch-model"
gem "elasticsearch-rails"

gem "devise"
gem "omniauth"
gem "omniauth_openid_connect"
gem "pundit", "2.0.0"
gem "role_model"

# Markdown
gem "github-markup"
gem "redcarpet"

# jira
gem "jira-ruby"

# redis
gem "redis-rails"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  gem "rspec-rails", "~> 3.7"

  gem "pry"
  gem "pry-byebug"
  gem "pry-rails"
  gem "pry-doc"
  gem "pry-nav"

  gem "dotenv-rails"

  gem "selenium-webdriver"
  gem "webdrivers", "~> 3.0"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rubocop-rails", ">=1.5.0"
  gem "overcommit", require: false
  gem "haml_lint", require: false
  gem "scss_lint", require: false
end

group :test do
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "capybara"
  gem "database_cleaner"
  gem "rack_session_access"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem "sentry-raven"
  gem "faker", require: false
end
