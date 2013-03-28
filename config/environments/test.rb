Lgdpm::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # Dalli memcache client library settings
  # config.cache_store = :dalli_store, 'cache-1.example.com', 'cache-2.example.com',
  #   { :namespace => LGDPM_test, :expires_in => 1.day, :compress => true }
  config.action_mailer.default_url_options = { :host => SETTINGS["mail"]["host"] }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  :address              => SETTINGS["mail"]["address"],
  :port                 => SETTINGS["mail"]["port"],
  :authentication       => SETTINGS["mail"]["authentication"],
  :user_name            => SETTINGS["mail"]["user_name"],
  :password             => SETTINGS["mail"]["password"],
  :enable_starttls_auto => SETTINGS["mail"]["enable_starttls_auto"],
  :domain               => SETTINGS["mail"]["domain"]
  }
end
