require "rails_helper"

RSpec.describe Challenge, type: :model do
  describe "関連付け" do
    it "Userに所属している" do
      challenge = Challenge.new
      expect(challenge).to respond_to(:user)
    end

    it "参考写真に所属している" do
      challenge = Challenge.new
      expect(challenge).to respond_to(:reference_photo)
    end
  end
end