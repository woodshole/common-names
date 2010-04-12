# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
$KCODE = 'u'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

require 'active_support/inflector'

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  #FlickRaw
  config.gem 'flickr_fu'
  
  # Stylesheet library.
  config.gem 'compass', :version => '0.8.17'
  
  # Alternate template and stylesheet engine.
  config.gem 'haml', :version => '2.2.15'

  # Show text-based progress bar for long-running console tasks.
  config.gem 'progressbar', :version => '0.9.0'  
  
  # Nested sets for storing hierarchies.
  config.gem 'awesome_nested_set', :version => '1.4.3'
  
  # Authentication
  config.gem 'authlogic', :version => '2.1.3'
  config.gem "authlogic-oid", :lib => "authlogic_openid", :version => "1.0.4"
  
  # Pagination
  config.gem 'will_paginate', :version => '2.3.11'
  
  # Null object pattern.
  config.gem 'activerecord_null_object', :version => "0.2.0"
  
  # Talk to karma server.
  config.gem 'rest-client', :lib => 'restclient', :version => '1.3.0'
  
  # Hoptoad notifier
  config.gem 'hoptoad_notifier', :version => '2.1.3'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  #we gotta tell rails that taxa is the plural of taxon
  ActiveSupport::Inflector.inflections do |inflect|
    inflect.irregular 'taxon', 'taxa'
  end

end
