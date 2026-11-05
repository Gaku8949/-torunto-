require 'rails_helper'

RSpec.describe ChallengeTechnique, type: :model do
  describe 'アソシエーション' do
    it 'チャレンジに紐づいていること' do
      association = described_class.reflect_on_association(:challenge)
      expect(association.macro).to eq(:belongs_to)
    end

    it '撮影技法に紐づいていること' do
      association = described_class.reflect_on_association(:technique)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end