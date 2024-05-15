FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { Faker::Internet.email }
    password { 'aaaaaa' }
    password_confirmation { 'aaaaaa' }
    address { 'Test Apartment, Test City' }
    phone_number { '1234567890' }
    role

    trait :admin do
      association :role, factory: %i[role admin]
    end

    trait :employee do
      association :role, factory: %i[role employee]
      association :service, factory: :service
    end

    trait :customer do
      association :role, factory: %i[role customer]
    end
  end
end
