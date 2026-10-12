require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profile" do
    it "returns http success" do
      user = User.create!(
        username: "testuser",
        email: "test@example.com",
        password: "password"
      )

      sign_in user

      get "/profile"

      expect(response).to have_http_status(:success)
    end
  end
end