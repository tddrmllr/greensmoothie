require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Greensmoothie
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.action_mailer.default_url_options = { :host => 'http://www.greensmoothie.me' }
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :authentication => "plain",
      :user_name => "todd.scalar",
      :password => "d@Rkn3ss",
      :enable_starttls_auto => true
    }

    #config.action_mailer.delivery_method = :postmark
    #config.action_mailer.postmark_settings = { :api_key => "fd37d6ed-b5d4-479e-9556-cad4127993d5" }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
