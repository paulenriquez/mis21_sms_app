class OutboxesController < ApplicationController
    def index
        @outboxes = Outboxes.all
    end
    def new
        @outbox = Outbox.new
    end
    def create
        @outbox = Outbox.new(outbox_params)
        if @outbox.save
        else
        end
    end
    def show
        @outbox = Outbox.find(params[:id])
    end
    def destroy

    end

    private def outbox_params
        params.require(:outbox).permit!
    end
    def send_message
        HTTParty.post()
    end
end
