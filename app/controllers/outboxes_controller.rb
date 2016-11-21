class OutboxesController < ApplicationController
    def index
        @outboxes = Outbox.all
    end

    def new
        @outbox = Outbox.new
        
        @outbox.mobile_number = params[:mobile_number] if not params[:mobile_number].blank?
        @outbox.message = params[:message] if not params[:message].blank?
    end

    def create
        @outbox = Outbox.new(outbox_params)
        if @outbox.save
            send_message(@outbox)
            redirect_to(outbox_path(@outbox.id))
        else
            redirect_to(new_outbox_path)
        end
    end

    def show
        @outbox = Outbox.find(params[:id])
    end

    private def outbox_params
        params.require(:outbox).permit(:mobile_number, :message)
    end
    private def send_message(sms_message)
        HTTParty.post(Rails.application.config.chikka_post_request_url, body: sms_message.attributes, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}, verify: false)
    end
end
