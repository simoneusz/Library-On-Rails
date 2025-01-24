FactoryBot.define do
  factory :history do
    taken_at { Time.current }
    user
    book
  end
end
