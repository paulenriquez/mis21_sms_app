class OutboxesController < ApplicationController
    def index
        @outboxes = Outbox.all
    end

    # new: Generate New Outbox Message Form
    def new
        @outbox = Outbox.new
    end

    # create: Save new Outbox Message
    def create
        @outbox = Outbox.new(outbox_params)
        @outbox.message_type = "SEND"
        if @outbox.save
            redirect_to(outbox_path(@outbox.id))
        else
            redirect_to(new_outbox_path)
        end
    end

    # show: Show created Outbox Message, then send
    def show
        @outbox = Outbox.find(params[:id])
    end

    # edit: Generate Re-send Outbox Message Form
    def edit
        @outbox = Outbox.find(params[:id])
    end
    
    # update: Save edited Outbox Message as new Message
    def update
        @outbox = Outbox.new(outbox_params)
        @outbox.message_type = "SEND"
        if @outbox.save
            redirect_to(outbox_path(@outbox.id))
        else
            redirect_to(new_outbox_path)
        end
    end

    private def outbox_params
        params.require(:outbox).permit!
    end
    private def send_message
        HTTParty.post(chikka_post_request_url, :body => message.to_json)
    end
end
