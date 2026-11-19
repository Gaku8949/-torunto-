require 'rails_helper'

RSpec.describe ChallengeFavorite, type: :model do
  describe 'アソシエーション' do
    it 'ユーザーに紐づいていること' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'チャレンジに紐づいていること' do
      association = described_class.reflect_on_association(:challenge)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'バリデーション' do
    it '同じユーザーが同じチャレンジを重複してお気に入り登録できないこと' do
      user = create(:user)
      challenge = build(:challenge)

      challenge.image.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/test.JPG")),
        filename: "test.JPG",
        content_type: "image/jpeg"
      )

      challenge.save!

      create(:challenge_favorite, user: user, challenge: challenge)

      duplicate_favorite = build(:challenge_favorite, user: user, challenge: challenge)

      expect(duplicate_favorite).not_to be_valid
    end
  end
end