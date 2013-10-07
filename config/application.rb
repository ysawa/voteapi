require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Voteapi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/lib)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators.stylesheet_engine = :sass

    if Rails.configuration.respond_to?(:sass)
      Rails.configuration.sass.tap do |config|
        config.preferred_syntax = :sass
      end
    end
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.svg)

    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'ALLOWALL',
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Allow-Headers" => "*",
      "Access-Control-Allow-Credentials" => "true"
    }

    config.generators do |g|
      g.test_framework :rspec, fixture: false, views: true, requests: true, routing: true, helpers: true
      g.fixture_replacement :fabrication, dir: 'spec/fabricators'
      g.helper false
      g.stylesheets false
      g.javascripts false
    end
  end
end
