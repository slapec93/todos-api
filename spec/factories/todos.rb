# Factory for Todo model
FactoryGirl.define do
  factory :todo do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
  end
end