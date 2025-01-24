FactoryBot.define do
  factory :book do
    name { SecureRandom.urlsafe_base64 }
    author_name { Faker::Book.author }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    image { File.open(Dir[Rails.root.join('db', 'seed_images', '*')].sample) }
  end
end
