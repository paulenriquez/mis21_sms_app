class Outbox < ApplicationRecord
    belongs_to :user
    before_save :complete_outbox_attributes

    validates :mobile_number, presence: true
    validates :message, presence: true

    private
        def complete_outbox_attributes
            self.message_type = 'SEND' if self.message_type = ''
            self.shortcode = Rails.application.config.chikka_api_shortcode
            self.message_id = generate_message_id
            self.client_id = Rails.application.config.chikka_api_client_id
            self.secret_key = Rails.application.config.chikka_api_secret_key
        end
        def generate_message_id
            message_id = SecureRandom.hex
            while Outbox.exists?(message_id: message_id, created_at: DateTime.now - 24.hours) do
                message_id = SecureRandom.hex
            end
            message_id
        end
end