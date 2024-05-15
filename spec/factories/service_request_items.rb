FactoryBot.define do
  factory :service_request_item do
    association :service_request
    association :option
    association :user
    time_slot { 'Wed, 22 May 2024 10:55:00.000000000 UTC +00:00' }
    status { :order_placed }
    order_placed { true }
    otp_secret_key { 'AAAAAA' }
    feedback { 'Sample feedback' }
  end
end
