require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let!(:user) do
    User.create!(
      username: "testuser",
      email: "test@example.com",
      password: "password"
    )
  end

  before do
    sign_in user
  end

  describe "GET /profile" do
    it "プロフィールページが正常に表示される" do
      get "/profile"

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /profile/edit" do
    it "プロフィールを更新できる" do
      patch "/profile/edit", params: {
        user: {
          username: "newuser",
          email: "new@example.com"
        }
      }

      expect(response).to redirect_to(profile_path)

      user.reload
      
      expect(user.username).to eq("newuser")
      expect(user.email).to eq("new@example.com")
    end
  end

  describe "未ログインの場合" do
    it "プロフィールページにアクセスできない" do
      sign_out user

      get "/profile"

      expect(response).to have_http_status(:redirect)
    end
  end
end