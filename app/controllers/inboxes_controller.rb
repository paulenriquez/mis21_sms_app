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
			if permitted_inbox_attributes.include?(key)
				@inbox[key] = value
			end
		end

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
end
