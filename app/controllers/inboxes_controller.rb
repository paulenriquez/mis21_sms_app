class InboxesController < ApplicationController
   #before_action :authenticate_user!
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

		send_confirmation_reply(@inbox)

		if @inbox.save
			render json: {status: 'Accepted'}
		else
			render json: {status: 'Error'}
		end
	end

	def show
		@inbox = Inbox.find(params[:id])
	end

	def destroy
		@inbox = Inbox.find(params[:id])
	    @inbox.destroy
	    redirect_to inboxes_path, notice: 'Inbox message successfully deleted!'
	end

	private
		def send_confirmation_reply(received_sms_message)
			reply_message = {}
			outbox = Outbox.new(id: -1, message_type: 'REPLY', mobile_number: received_sms_message.mobile_number, message: Rails.application.config.chikka_api_confirmation_reply_message)

			outbox.save
			Outbox.find(-1).attributes.each do |key, value|
				reply_message[key] = value
			end
			Outbox.find(-1).destroy

			reply_message[request_id] = received_sms_message.request_id
			reply_message[request_cost] = 'FREE'

			HTTParty.post(Rails.application.config.chikka_api_post_request_url, body: reply_message.attributes, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}, verify: false)
		end
end
