class OutboxesController < ApplicationController
    def index
        @outboxes = Outbox.all
    end

    # new: Generate New Outbox Message Form
    def new
        @outbox = Outbox.new
    end

    # create: Save new Outbox Message, and Send
    def create
        @outbox = Outbox.new(outbox_params)
        @outbox.message_type = "SEND"
        if @outbox.Save
            
        else
        end
    end
    def show
        @outbox = Outbox.find(params[:id])
        send_message(@outbox)
    end

    # edit: Generate Re-send Outbox Message Form
    def edit
        @outbox = Outbox.find_by(params[:id])
    end

    
    def destroy

    end

    private def outbox_params
        params.require(:outbox).permit!
    end
    private def send_message
        HTTParty.post(chikka_post_request_url, :body => message.to_json)
    end
end
