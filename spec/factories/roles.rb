FactoryBot.define do
  factory :role do
    name { 'sample role' }

    trait :admin do
      name { 'admin' }
    end

    trait :employee do
      name { 'employee' }
    end

    trait :customer do
      name { 'customer' }
    end
  end
end
