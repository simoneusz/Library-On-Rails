FactoryBot.define do
  factory :comment do
    user { 'books/show' }
    association :user
    association :book
  end
end
