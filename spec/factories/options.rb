FactoryBot.define do
  factory :option do
    title { 'Test Option Title' }
    description { 'This is a description for Test option.' }
    price { 1000 }
    duration { 3 }
    association :service
  end
end
