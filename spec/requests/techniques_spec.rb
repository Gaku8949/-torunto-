require 'rails_helper'

RSpec.describe "Techniques", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/techniques/show"
      expect(response).to have_http_status(:success)
    end
  end

end
