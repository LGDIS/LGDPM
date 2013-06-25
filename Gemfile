source 'https://rubygems.org'

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

# Use unicorn as the app server. LGDPM default Rack HTTP Server.
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

# omniauth is external-authorize for Devise.
# A generalized Rack framework for multiple-provider authentication.
gem 'omniauth'

# OpenID strategy for OmniAuth. Using for Google.
gem 'omniauth-openid'
gem "ruby-openid", :git => "git://github.com/kendagriff/ruby-openid.git", :ref => "79beaa419d4754e787757f2545331509419e222e"

# A generic OAuth (1.0/1.0a) strategy for OmniAuth.
gem 'omniauth-oauth'

# An abstract OAuth2 strategy for OmniAuth. Using for Facebook.
gem 'omniauth-oauth2'

# A generic SAML strategy for OmniAuth.
gem 'omniauth-saml', '1.0.0', :git => 'https://github.com/ruvr/omniauth-saml.git'

# OmniAuth strategy for Twitter.
gem 'omniauth-twitter'

# Facebook strategy for OmniAuth.
gem 'omniauth-facebook'

# LDAP strategy for OmniAuth.
gem 'omniauth-ldap'

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

# Resque is a Redis-backed Ruby library for creating background jobs,
# placing those jobs on multiple queues, and processing them later.
gem 'resque', :require => 'resque/server'

# libzip is a C library for reading, creating, and modifying zip archives.
gem 'zipruby'

group :test do
  # Rspec-2 meta-gem that depends on the other components.
  gem 'rspec'

  # factory_girl is a fixtures replacement with a straightforward
  # definition syntax, support for multiple build strategies (saved
  # instances, unsaved instances, attribute hashes, and stubbed objects),
  # and support for multiple factories for the same class (user,
  # admin_user, and so on), including factory inheritance.
  gem 'factory_girl_rails'

  # RSpec matcher for Resque.
  gem 'resque_spec'
end

# Iconv is a wrapper class for the UNIX 95 iconv() function family,
# which translates string between various encoding systems.
platforms :mri_20 do
  gem "iconv"
end

gem 'rake', '10.0.4'

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
