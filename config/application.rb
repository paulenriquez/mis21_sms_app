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
    
    config.chikka_api_shortcode = "292906635"
    config.chikka_api_client_id = "7baf2b6a84ee063aba075989d46da6a1037429f7e57a59db15e2e6dd15abf83c"
    config.chikka_api_secret_key = "7f0558d7f9f3d300448f316b74c3d184ed66eb5738534b23488e29ab597fa7ee"
    config.chikka_post_request_url = "https://post.chikka.com/smsapi/request"
    config.chikka_confirmation_reply_message = "Message received."
  end
end
