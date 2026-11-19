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
    photo = Photo.new(
      user: user,
      title: "参考写真",
      description: "参考写真の説明"
    )

    photo.image.attach(
      io: File.open(Rails.root.join("spec/fixtures/files/test.JPG")),
      filename: "test.JPG",
      content_type: "image/jpeg"
    )

    photo.save!
    photo
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
            comment: "撮影してみました",
            image: fixture_file_upload(
              "test.JPG",
              "image/jpeg"
            )
          }
        }
      }.to change(Challenge, :count).by(1)

      expect(response).to redirect_to(photo_path(photo))
    end
  end

  describe "GET /photos/:photo_id/challenges/:id/edit" do
    it "チャレンジ編集ページが正常に表示される" do
      challenge = Challenge.new(
        user: user,
        reference_photo: photo,
        title: "変更前",
        location: "福岡",
        comment: "変更前コメント"
      )

      challenge.image.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/test.JPG")),
        filename: "test.JPG",
        content_type: "image/jpeg"
      )

      challenge.save!

      get edit_photo_challenge_path(photo, challenge)

      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /photos/:photo_id/challenges/:id" do
    it "チャレンジを編集できる" do
      challenge = Challenge.new(
        user: user,
        reference_photo: photo,
        title: "変更前",
        location: "福岡",
        comment: "変更前コメント"
      )

      challenge.image.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/test.JPG")),
        filename: "test.JPG",
        content_type: "image/jpeg"
      )

      challenge.save!

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