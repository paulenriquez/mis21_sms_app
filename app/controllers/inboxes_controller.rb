class InboxesController < ApplicationController
   #before_action :authenticate_user!

	def index
	    @inboxes = Inbox.all
	end

	def new
	    @inbox = Inbox.new
	end

	def create
	    @inbox = current_user.inboxes.new(inbox_params)

	    if @inbox.save
	      redirect_to inboxes_path, notice: 'Inbox message successfully created!'
	    else
	      render :new
	    end
	end

	def show
	end

	def notify
	end

	def destroy

	    @inbox.destroy
	    redirect_to inboxes_path, notice: 'Inbox message successfully deleted!'
	end

end
