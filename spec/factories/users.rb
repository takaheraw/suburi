FactoryBot.define do
  factory :user do
    email     { Faker::Internet.free_email }
    password  { Faker::Internet.password   }
    role      { "user" }
  end
end
