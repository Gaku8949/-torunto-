require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "関連付け" do
    it "Userに所属している" do
      comment = Comment.new
      expect(comment).to respond_to(:user)
    end

    it "Photoに所属している" do
      comment = Comment.new
      expect(comment).to respond_to(:photo)
    end
  end
end