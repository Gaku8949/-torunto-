require 'rails_helper'

RSpec.describe ChallengeComment, type: :model do
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
end