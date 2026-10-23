require 'rails_helper'

RSpec.describe "HowToUses", type: :request do
  describe "GET /how_to_uses/show" do
    it "使い方ページが正常に表示される" do
      get "/how_to_uses/show"

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /how_to_use" do
    it "使い方ページが正常に表示される" do
      get "/how_to_use"

      expect(response).to have_http_status(:success)
    end
  end
end