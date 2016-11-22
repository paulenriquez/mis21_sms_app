class OutboxesController < ApplicationController
    def index
        @outboxes = Outbox.all
    end

    def new
        @outbox = Outbox.new
        params.keys.each do |key, value|
            @outbox[key] = value if not params[key].blank?
        end
    end

    def create
        @outbox = Outbox.new(outbox_params)
        if @outbox.save
            send_message(sms_message)
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
            HTTParty.post(Rails.application.config.chikka_post_request_url, body: sms_message.attributes, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}, verify: false)
        end                   
end
