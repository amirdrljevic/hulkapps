source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.7"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'faker', '~> 3.2', '>= 3.2.1'
gem 'will_paginate', '~> 4.0'
gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.2'
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'

#Set up environment variables to safely store credentials
gem 'dotenv-rails', groups: [:development, :test]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "devise", "~> 4.9"
