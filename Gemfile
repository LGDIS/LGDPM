source 'http://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Pg is the Ruby interface to the PostgreSQL RDBMS.
# It works with PostgreSQL 8.3 and later.
gem 'pg', '0.14.1'

# ActiveRecord extension to get more from PostgreSQL.
gem 'pg_power', '1.3.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '0.11.3', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '2.2.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server. LGDPM default Rack HTTP Server.
gem 'unicorn', '4.5.0'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# Dalli is a high performance pure Ruby client for accessing memcached servers.
gem 'dalli', '2.6.0'

# jpmobile is Rails plugin for Japanese mobile-phones.
gem 'jpmobile', '3.0.7'

# Devise is Flexible authentication solution for Rails with Warden.
gem 'devise', '2.2.2'

# Devise extension to allow authentication via LDAP.
gem 'devise_ldap_authenticatable', '0.6.1'

# meta_search is Allows simple search forms to be created against an AR3
# model and its associations, has useful view helpers for sort links and
# multiparameter fields as well.
gem 'meta_search', '1.1.3'

# acts_as_paranoid is Active Record (~>3.2) plugin which allows you to
# hide and restore records without actually deleting them.
gem 'acts_as_paranoid', '0.4.1'

# TabsOnRails is a simple Rails plugin for creating tabs and navigation menus.
gem 'tabs_on_rails', '2.1.1'

# will_paginate provides a simple API for performing paginated queries with
# Active Record, DataMapper and Sequel, and includes helpers for rendering
#  pagination links in Rails, Sinatra and Merb web apps.
gem 'will_paginate', '3.0.4'

# ThinReports is Open Source Reporting Solution for Ruby. It provides a GUI
# Designer and a Library for Ruby.
gem 'thinreports', '0.7.6'

# Load Local Gemfile
local_gemfile = File.join(File.dirname(__FILE__), "Gemfile.local")
if File.exists?(local_gemfile)
  puts "Loading Gemfile.local ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(local_gemfile)
end

# Load plugins' Gemfiles
Dir.glob File.expand_path("../plugins/*/Gemfile", __FILE__) do |file|
  puts "Loading #{file} ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(file)
end
