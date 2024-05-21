module Services
  module OtpService
    # Class to send OTP to customer
    class OtpSender
      def initialize(service_request_item)
        @service_request_item = service_request_item
      end

      def send_otp
        twilio_client = TwilioClient.new
        customer_phone = "+91#{@service_request_item.service_request.user.phone_number}"
        twilio_client.send_text(customer_phone,
                                "Your OTP is #{@service_request_item.otp_code}. Please share this with the service agent to avail the service.")
      end
    end
  end
end
