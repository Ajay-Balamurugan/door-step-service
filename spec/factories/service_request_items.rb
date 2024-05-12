FactoryBot.define do
  factory :service_request_item do
    association :service_request, factory: :service_request
    association :option, factory: :option
    time_slot { Faker::Time.between(from: DateTime.now + 1.day, to: DateTime.now + 60.days, period: :morning) }
    status { 'order_placed' }
    otp_secret_key { Faker::Alphanumeric.alphanumeric(number: 4) }
  end
end
