FactoryBot.define do
  factory :employee_slot do
    association :user, factory: :user
    association :service_request_item, factory: :service_request_item
    time_slot { 'Wed, 22 May 2024 10:55:00.000000000 UTC +00:00' }
  end
end
