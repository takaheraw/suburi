FactoryBot.define do
  factory :user do
    email     { Faker::Internet.free_email }
    password  { Faker::Internet.password   }
    role      { "user" }

    before(:create) do |user|
      user.skip_confirmation_notification!
      user.skip_confirmation!
    end

  end
end
