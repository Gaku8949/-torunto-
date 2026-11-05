FactoryBot.define do
  factory :challenge_favorite do
    association :user
    association :challenge
  end
end