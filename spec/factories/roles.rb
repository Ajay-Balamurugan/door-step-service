# spec/factories/roles.rb
FactoryBot.define do
  factory :role do
    name { 'customer' }

    trait :admin do
      name { 'admin' }
    end

    trait :employee do
      name { 'employee' }
    end

    trait :customer do
      name { 'Customer' }
    end
  end
end
