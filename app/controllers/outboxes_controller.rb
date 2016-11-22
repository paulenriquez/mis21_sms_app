class OutboxesController < ApplicationController
    # before_action :authenticate_user!
    def index
        @outboxes = Outbox.all
    end

    def new
        @outbox = Outbox.new do |outbox|
            outbox.mobile_number = params[:mobile_number]
            outbox.message = params[:message]
        end
    end

    def create
        @outbox = Outbox.new(outbox_params)
        @outbox.message_type = "SEND"
        if @outbox.save
            send_message(@outbox)
            redirect_to outbox_path(@outbox.id)
        else
            redirect_to new_outbox_path(send_type: 'resend')
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
