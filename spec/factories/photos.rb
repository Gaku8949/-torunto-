FactoryBot.define do
  factory :photo do
    association :user
    title { "テスト写真" }
    description { "テスト用の写真です" }
    location { "福岡市" }
  end
end