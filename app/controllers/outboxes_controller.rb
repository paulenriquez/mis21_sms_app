class OutboxesController < ApplicationController
    before_action :authenticate_user!

    def index
        @outboxes = Outbox.all
    end

    def new
        @outbox = Outbox.new
    end

    def resend
        @outbox = Outbox.find(params[:id])
    end

    def create
        @outbox = current_user.outboxes.new(outbox_params)
        if @outbox.save
            send_message(@outbox)
            redirect_to sent_outbox_path(@outbox)
        else
            render :new
        end
    end

    def sent
        @outbox = Outbox.find(params[:id])
        @return_link = {}
        if params[:from] == 'inbox'
            @return_link = {text: 'Return to Inbox', link: inboxes_path}
        else
            @return_link = {text: 'Return to Outbox', link: outboxes_path}
        end
    end

    def show
        @outbox = Outbox.find(params[:id])
    end

    private
        def outbox_params
            params.require(:outbox).permit(:mobile_number, :message)
        end
        def send_message(sms_message)
            HTTParty.post(Rails.application.config.chikka_api_post_request_url, body: sms_message.attributes, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}, verify: false)
        end                   
end
