require 'rails_helper'

RSpec.describe Services::OtpService::OtpSender do
  describe '#send otp' do
    let(:user) { create(:user, :customer, phone_number: '9945799278') }
    let(:option1) { create(:option) }
    create(:service_request_item, user:, option: option1, order_placed: true)

    it 'sends the otp' do
      otp_sender = described_class.new(service_request_item)
      total = otp_sender.send_otp
    end
  end
end
