FactoryBot.define do
  factory :service do
    title { 'Test Service' }
    description { 'This is a description for Test service.' }

    after(:create) do |service|
      service.images.attach(
        io: File.open(Rails.root.join('app/assets/images//services/home2.jpg')),
        filename: 'home2.jpg',
        content_type: 'image/jpeg'
      )
      service.images.attach(
        io: File.open(Rails.root.join('app/assets/images//services/home3.jpg')),
        filename: 'home3.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
