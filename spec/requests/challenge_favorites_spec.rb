require 'rails_helper'

RSpec.describe "ChallengeFavorites", type: :request do
  let(:user) { create(:user) }
  let(:challenge) { create(:challenge) }

  before do
    sign_in user
  end

  describe "POST /challenges/:challenge_id/challenge_favorite" do
    it "お気に入り登録できること" do
      expect {
        post challenge_challenge_favorite_path(challenge)
      }.to change(ChallengeFavorite, :count).by(1)

      expect(response).to redirect_to(challenges_path)
    end
  end

  describe "DELETE /challenges/:challenge_id/challenge_favorite" do
    it "お気に入り解除できること" do
      create(:challenge_favorite, user: user, challenge: challenge)

      expect {
        delete challenge_challenge_favorite_path(challenge)
      }.to change(ChallengeFavorite, :count).by(-1)

      expect(response).to redirect_to(challenges_path)
    end
  end
end