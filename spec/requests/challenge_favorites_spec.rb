require 'rails_helper'

RSpec.describe "ChallengeFavorites", type: :request do
  let(:user) { create(:user) }
  
  let(:photo) do
    photo = Photo.new(
      user: user,
      title: "参考写真"
    )

    photo.image.attach(
      io: File.open(Rails.root.join("spec/fixtures/files/test.JPG")),
      filename: "test.JPG",
      content_type: "image/jpeg"
    )

    photo.save!
    photo
  end

  let(:challenge) do
    challenge = Challenge.new(
      user: user,
      reference_photo: photo,
      title: "チャレンジ写真"
    )

    challenge.image.attach(
      io: File.open(Rails.root.join("spec/fixtures/files/test.JPG")),
      filename: "test.JPG",
      content_type: "image/jpeg"
    )

    challenge.save!
    challenge
  end

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