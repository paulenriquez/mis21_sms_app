class Outbox < ApplicationRecord
    before_save :complete_outbox_attributes

    private def complete_outbox_attributes
        self.shortcode = Rails.application.config.chikka_api_shortcode
        self.message_id = generate_message_id
        self.client_id = Rails.application.config.chikka_api_client_id
        self.secret_key = Rails.application.config.chikka_api_secret_key
    end
    private def generate_message_id
        message_id = SecureRandom.hex
        while Outbox.exists?(message_id: message_id) do
            message_id = SecureRandom.hex
        end
        message_id
    end
end
