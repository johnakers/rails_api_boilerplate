FactoryBot.define do
  factory :thing do
    name { Faker::Games::Myst.creature }
  end
end
