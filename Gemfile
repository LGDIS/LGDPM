source 'http://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Pg is the Ruby interface to the PostgreSQL RDBMS.
# It works with PostgreSQL 8.3 and later.
gem 'pg'

# ActiveRecord extension to get more from PostgreSQL.
gem 'pg_power'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server. LGDPF default Rack HTTP Server.
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# Dalli is a high performance pure Ruby client for accessing memcached servers.
gem 'dalli'

# jpmobile is Rails plugin for Japanese mobile-phones.
gem 'jpmobile'

# Devise is Flexible authentication solution for Rails with Warden.
gem 'devise'

# Devise extension to allow authentication via LDAP.
gem 'devise_ldap_authenticatable'

# meta_search is Allows simple search forms to be created against an AR3
# model and its associations, has useful view helpers for sort links and
# multiparameter fields as well.
gem 'meta_search'

# acts_as_paranoid is Active Record (~>3.2) plugin which allows you to
# hide and restore records without actually deleting them.
gem 'acts_as_paranoid'

# TabsOnRails is a simple Rails plugin for creating tabs and navigation menus.
gem 'tabs_on_rails'

# will_paginate provides a simple API for performing paginated queries with
# Active Record, DataMapper and Sequel, and includes helpers for rendering
#  pagination links in Rails, Sinatra and Merb web apps.
gem 'will_paginate'

# ThinReports is Open Source Reporting Solution for Ruby. It provides a GUI
# Designer and a Library for Ruby.
gem 'thinreports'

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
