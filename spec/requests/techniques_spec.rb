require 'rails_helper'

RSpec.describe "Techniques", type: :request do
  describe "GET /show" do
    it "returns http success" do
      technique = Technique.create!(
        name: "三分割法"
      )

      get technique_path(technique)

      expect(response).to have_http_status(:success)
    end
  end
end
