source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 2.0'

# Use Puma as the app server
gem 'puma', '~> 6.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.4'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use SCSS for stylesheets
gem 'sassc-rails'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 4.0'
  gem 'listen', '~> 3.3'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'factory_bot_rails'
end

# Windows (and our docker image?) does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data' # , platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-oauth2'
gem 'omniauth-twitter'

gem 'cancancan'

gem 'jquery-rails'
gem 'bootstrap', '~> 5.0'
gem 'bootstrap_form', '~> 5.0'

gem 'rails-html-sanitizer'
gem 'github-markup', require: 'github/markup'
gem 'redcarpet'

gem 'kaminari'
gem 'friendly_id'
gem 'acts-as-taggable-on'
gem 'paper_trail'

gem 'config'

gem 'whenever'
gem 'rolify'

gem 'lograge'
gem 'secure_headers'
gem 'honeybadger'
gem 'slowpoke'
gem 'rack-attack'

gem 'google-analytics-rails'

gem 'classifier-reborn'

group :production do
  gem 'pg'
end

gem 'gmail'
gem 'rails_autolink'
gem 'paranoia'

gem 'faraday'
gem 'page_title_helper'
gem 'sitemap_generator'
gem 'popper_js'
gem 'recaptcha'
gem 'rss'
