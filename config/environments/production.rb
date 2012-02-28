Promesometro::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = true
  
  ActionMailer::Base.smtp_settings = {
    :address        => 'http://mail.promesometro.pe/',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'www.promesometro.pe'
  }
  ActionMailer::Base.delivery_method = :smtp

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"
  
  #config.action_controller.asset_host = "http://asset%d.promesometro.pe"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  #config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
    ENV['GEM_PATH'] = "/home/promesometro/.gems" #+ ':/usr/lib/ruby/gems/1.8'  # Need this or Passenger fails to start
    #require "#{ENV["HOME"]}/.gems/gems/RedCloth-4.1.9/lib/redcloth.rb"  # Need this for EACH LOCAL gem you want to use, otherwise it uses the ones in /usr/lib
  end
end
