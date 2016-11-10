class OutboxesController < ApplicationController
    def index
        @outboxes = Outbox.all
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
        send_message(@outbox)
    end
    def destroy

    end

    private def outbox_params
        params.require(:outbox).permit!
    end
    private def send_message()
        chikka_post_request_url = "https://post.chikka.com/smsapi/request"
        HTTParty.post(chikka_post_request_url, :body => message.to_json)
    end
end
