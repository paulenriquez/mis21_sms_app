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
    config.chikka_api_post_request_url = "https://post.chikka.com/smsapi/request"
    config.chikka_api_shortcode = "29290000007"
    config.chikka_api_client_id = "2f12212f84113ccafbae7d78630d15fe35f50a84107d5b04037bfd04afb6471a"
    config.chikka_api_secret_key = "0b965f20ab2bbb7dcadd50fb91843cb8d9632a512ff249a3a1e45a4d6eb32f32"
  end
end
