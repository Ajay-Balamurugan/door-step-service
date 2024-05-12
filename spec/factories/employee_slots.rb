FactoryBot.define do
  factory :employee_slot do
    association :user, factory: :user
    association :service_request_item, factory: :service_request_item
    time_slot { Faker::Time.between(from: DateTime.now + 1.day, to: DateTime.now + 60.days, period: :morning) }
  end
end
