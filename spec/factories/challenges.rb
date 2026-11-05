FactoryBot.define do
  factory :challenge do
    association :user
    association :reference_photo, factory: :photo

    title { "テストチャレンジ" }
    comment { "テスト用のチャレンジ" }
    location { "福岡市" }
  end
end