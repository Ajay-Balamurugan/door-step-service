FactoryBot.define do
  factory :service_request do
    association :user
    total { 100 }
  end
end
