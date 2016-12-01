class InboxesController < ApplicationController
   before_action :authenticate_user!, except: [:receive]
   protect_from_forgery except: [:receive]

	def index
	    @inboxes = Inbox.all
	end

	def receive
		@inbox = Inbox.new
		permitted_inbox_attributes = Inbox.column_names - ['id', 'created_at', 'updated_at']

		request.params.each do |key, value|
			@inbox[key] = value if permitted_inbox_attributes.include?(key)
		end

		if @inbox.save
			render json: {status: 'Accepted'}
			send_confirmation_reply(@inbox)
		else
			render json: {status: 'Error'}
		end
	end

	def show
		@inbox = Inbox.find(params[:id])
	end


	def edit
		@inbox = Inbox.find(params[:id])
		@outbox = Outbox.new(message: @inbox.message)
	end

	def update
		@outbox = Outbox.new(outbox_params)
		@outbox.message_type = 'SEND'
		if @outbox.save
			redirect_to inboxes_path, notice: 'Inbox message successfully forwarded!'
		else
			render :edit
		end
	end


	def destroy
		@inbox = Inbox.find(params[:id])
	    @inbox.destroy
	    redirect_to inboxes_path, notice: 'Inbox message successfully deleted!'
	end

	private
		def send_confirmation_reply(received_sms_message)
			reply_message = {
				message_type: 'REPLY',
				mobile_number: received_sms_message.mobile_number,
				shortcode: Rails.application.config.chikka_api_shortcode,
				request_id: received_sms_message.request_id,
				message_id: SecureRandom.hex,
				message: Rails.application.config.chikka_api_confirmation_reply_message,
				request_cost: 'FREE',
				client_id: Rails.application.config.chikka_api_client_id,
				secret_key: Rails.application.config.chikka_api_secret_key
			}
			HTTParty.post(Rails.application.config.chikka_api_post_request_url, body: reply_message, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}, verify: false)
		end

		def outbox_params
            params.require(:outbox).permit(:mobile_number, :message)
        end

end
