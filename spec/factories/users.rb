FactoryBot.define do
  # this user is not banana-able - it needs to correspond to a model name
  factory :user do
    username { Faker::Movies::HarryPotter.character }
    email { "Faker::Internet.email" }
    password { "password" }
    age { 20 }
    political_affiliation { Faker::Movies::HarryPotter.house }
  end
end