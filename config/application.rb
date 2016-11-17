require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mis21SmsApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded."
    config.chikka_post_request_url = "https://post.chikka.com/smsapi/request"
    config.chikka_api_shortcode = "29290717"
    config.chikka_api_client_id = "bb9bea66a54ce8f148ac94f924ff779cc25cf920892644ac923b7d8f8328c211"
    config.chikka_api_secret_key = "3d5c8a8e3741fc43f51a8dc6041e28bf3950d5bea1314660ad4c5e76d4ccc3e8"
  end
end
