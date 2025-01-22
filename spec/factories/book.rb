images_path = Rails.root.join('db', 'seed_images')
image_files = Dir[images_path.join('*')]
random_image = image_files.sample

FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    author_name { Faker::Book.author }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    image { File.open(random_image) }
  end
end
