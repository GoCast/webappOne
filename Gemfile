source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'haml'
gem 'sass'
gem 'slim'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'devise'

gem "oa-oauth", :require => "omniauth/oauth"

# Use unicorn as the web server
gem 'unicorn'

gem 'execjs'
gem 'therubyracer'
# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'mysql2'

group :development do  
  gem "powder"
end

group :test do
  # Pretty printed test output
  gem "rspec-rails", "~> 2.6"
  gem "capybara"
  gem "shoulda"

  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-shell'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-shell'
  gem 'guard-bundler'
  gem 'guard-pow'
  gem "spork"
end
