FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    association :user
    association :book
  end
end
