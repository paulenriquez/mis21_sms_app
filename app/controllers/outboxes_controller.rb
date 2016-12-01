class OutboxesController < ApplicationController
    before_action :authenticate_user!

    def index
        @outboxes = Outbox.all
    end

    def new
        @outbox = Outbox.new
    end

    def create
        @outbox = current_user.outboxes.new(outbox_params)
        @outbox.message_type = 'SEND'
        if @outbox.save
            send_message(@outbox)
            redirect_to outbox_path(@outbox)
        else
            render :new
        end
    end

    def show
        @outbox = Outbox.find(params[:id])
    end

    def edit
        @outbox = Outbox.find(params[:id])
    end

    def update
        @outbox = current_user.outboxes.new(outbox_params)
        @outbox.message_type = 'SEND'
        if @outbox.save
            send_message(@outbox)
            redirect_to outbox_path(@outbox)
        else
            render :edit
        end
    end

    private
        def outbox_params
            params.require(:outbox).permit(:mobile_number, :message)
        end
        def send_message(sms_message)
            HTTParty.post(Rails.application.config.chikka_api_post_request_url, body: sms_message.attributes, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}, verify: false)
        end                   
end
