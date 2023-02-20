source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'factory_bot_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
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
gem 'bootstrap', '~> 4.x'
gem 'bootstrap_form'

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
gem 'redis'

group :production do
  gem 'pg'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

gem 'gmail'
gem 'rails_autolink'
gem 'paranoia'

gem 'faraday'
gem 'page_title_helper'
gem 'sitemap_generator'
gem 'popper_js'
gem 'recaptcha'
