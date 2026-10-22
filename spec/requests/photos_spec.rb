require 'rails_helper'

RSpec.describe "Photos", type: :request do
  let!(:user) do
    User.create!(
      username: "テストユーザー",
      email: "test@example.com",
      password: "password"
    )
  end

  before do
    sign_in user
  end

  describe "GET /photos" do
    it "写真一覧ページが正常に表示される" do
      get photos_path

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /photos/:id" do
    it "写真詳細ページが正常に表示される" do
      photo = Photo.create!(
        user: user,
        title: "テスト写真",
        description: "テスト説明"
      )

      get photo_path(photo)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /photos/new" do
    it "写真投稿ページが正常に表示される" do
      get new_photo_path

      expect(response).to have_http_status(:success)
    end
  end
end