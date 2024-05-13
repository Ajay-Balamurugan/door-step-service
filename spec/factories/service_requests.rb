FactoryBot.define do
  factory :service_request do
    association :user
    total { 10.99 }
  end
end
