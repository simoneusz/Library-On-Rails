FactoryBot.define do
  factory :rating do
    stars { [1, 2, 3, 4, 5].sample }
    user
    book
  end
end
