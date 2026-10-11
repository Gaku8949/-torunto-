require 'rails_helper'

RSpec.describe "HowToUses", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/how_to_uses/show"
      expect(response).to have_http_status(:success)
    end
  end

end
