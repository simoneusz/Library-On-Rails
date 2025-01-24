FactoryBot.define do
  factory :book do
    name { SecureRandom.urlsafe_base64 }
    author_name { Faker::Book.author }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_image.png'), 'image/jpeg') }
  end
end
