class InboxesController < ApplicationController
   #before_action :authenticate_user!

	def index
	    @inboxes = Inbox.all
	end

	def new
	    @inbox = Inbox.new
	end

	def create
	    #@inbox = current_user.inboxes.new(inbox_params)
	    @inbox = Inbox.new(inbox_params)
	    if @inbox.save
	      redirect_to inboxes_path, notice: 'Inbox message successfully created!'
	    else
	      render :new
	    end
	end

	def show
		@inbox = Inbox.find(params[:id])
	end

	def edit
		@inbox = Inbox.find(params[:id])
	end

    def update
    	@inbox = Inbox.find params[:id]
      if @inbox.update(inbox_params)
        redirect_to inboxes_path, notice: 'Inbox message successfully edited!'
      else
        render :edit
      end
    end

	def notify
	end

	def destroy
		@inbox = Inbox.find(params[:id])
	    @inbox.destroy
	    redirect_to inboxes_path, notice: 'Inbox message successfully deleted!'
	end

	private 
		def inbox_params
			params.require(:inbox).permit!
		end

	    def set_inbox
      		@inbox = Inbox.find(params[:id])
    	end	

end
