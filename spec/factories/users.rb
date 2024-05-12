# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'testuser@test.com' }
    password { 'aaaaaa' }
    password_confirmation { 'aaaaaa' }
    address { 'Test Apartment, Test City' }
    phone_number { '1234567890' }
    role { association(:role, :customer) }

    trait :admin do
      role { association(:role, :admin) }
    end

    trait :employee do
      role { association(:role, :employee) }
      service { association(:service) }
    end

    trait :customer do
      role { association(:role, :customer) }
    end
  end
end
