source 'https://rubygems.org'

ruby "2.2.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'sqlite3'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
gem 'puma'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


group :development do
  gem 'better_errors',      '~> 2.1.1'
  gem 'binding_of_caller',  '~> 0.7.2'
  gem 'quiet_assets',       '~> 1.1.0'
  gem 'rack-handlers',      '~> 0.7.0'
  gem 'letter_opener_web',  '~> 1.3.0'
end

# Test Frameworks
group :development, :test do
  gem 'spring-commands-rspec',  '~> 1.0.4',   require: false
  gem 'rspec-rails',            '~> 3.2.1'
  gem 'rspec-its',              '~> 1.2.0',   require: false
  gem 'shoulda-matchers',       '~> 2.8.0',   require: false
  gem 'json_expressions',       '~> 0.8.3',   require: false
  gem 'simplecov',              '~> 0.10.0',  require: false
  gem 'simplecov-rcov',         '~> 0.2.3',   require: false
  gem 'brakeman',               '~> 3.0.3',   require: false
end

## Factory Girl
gem 'factory_girl_rails', '~> 4.5.0'

# Locale
gem 'rails-i18n', '~> 4.0.4'

# Auth plugins
gem 'devise',       '~> 3.4.1'
gem 'devise-i18n',  '~> 0.11.3'

# Configuration plugins
gem 'settingslogic', '~> 2.0.9'

# environment variables from .env
gem 'dotenv-rails', '~> 1.0.2'

# View
gem 'haml-rails', '~> 0.9.0'

# CSS
gem 'normalize-rails',  '~> 3.0.3'

# Bootstrap
gem 'bootstrap-sass',                   '~> 3.3.4.1'
gem 'font-awesome-rails',               '~> 4.3.0.0'
gem 'select2-rails',                    '~> 3.5.9.3'
gem 'momentjs-rails',                   '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails',  '~> 4.7.14'

# ActiveRecord plugins
gem 'kaminari',   '~> 0.16.3'
gem 'enumerize',  '~> 0.11.0'

# API plugins
gem 'grape',  '~> 0.11.0'

# OAuth2 provider
gem 'doorkeeper', '~> 2.2.1'

