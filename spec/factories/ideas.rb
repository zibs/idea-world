FactoryGirl.define do
  factory :idea do
    association :user, factory: :user
    title { Faker::Hacker.ingverb}
    body {Faker::Shakespeare.hamlet_quote}
  end
end
