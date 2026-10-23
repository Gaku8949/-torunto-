require 'rails_helper'

RSpec.describe "Challenges", type: :request do
  let!(:user) do
    User.create!(
      username: "テストユーザー",
      email: "test@example.com",
      password: "password"
    )
  end

  let!(:photo) do
    Photo.create!(
      user: user,
      title: "参考写真",
      description: "参考写真の説明"
    )
  end

  before do
    sign_in user
  end

  describe "GET /challenges" do
    it "チャレンジ一覧ページが正常に表示される" do
      get challenges_path

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /photos/:photo_id/challenges/new" do
    it "チャレンジ投稿ページが正常に表示される" do
      get new_photo_challenge_path(photo)

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /photos/:photo_id/challenges" do
    it "撮影チャレンジを投稿できる" do
      expect {
        post photo_challenges_path(photo), params: {
          challenge: {
            title: "チャレンジ写真",
            location: "福岡",
            comment: "撮影してみました"
          }
        }
      }.to change(Challenge, :count).by(1)

      expect(response).to redirect_to(photo_path(photo))
    end
  end

  describe "GET /photos/:photo_id/challenges/:id/edit" do
    it "チャレンジ編集ページが正常に表示される" do
      challenge = Challenge.create!(
        user: user,
        reference_photo: photo,
        title: "チャレンジ写真",
        location: "福岡",
        comment: "テストコメント"
      )

      get edit_photo_challenge_path(photo, challenge)

      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /photos/:photo_id/challenges/:id" do
    it "チャレンジを編集できる" do
      challenge = Challenge.create!(
        user: user,
        reference_photo: photo,
        title: "変更前",
        location: "福岡",
        comment: "変更前コメント"
      )

      patch photo_challenge_path(photo, challenge), params: {
        challenge: {
          title: "変更後",
          location: "天神",
          comment: "変更後コメント"
        }
      }

      expect(response).to redirect_to(challenges_path)

      challenge.reload

      expect(challenge.title).to eq("変更後")
      expect(challenge.location).to eq("天神")
      expect(challenge.comment).to eq("変更後コメント")
    end
  end
end