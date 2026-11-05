FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test_user_#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password123" }
  end
end