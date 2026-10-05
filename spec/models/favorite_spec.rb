require "rails_helper"

RSpec.describe Favorite, type: :model do
  describe "関連付け" do
    it "Userに所属している" do
      favorite = Favorite.new
      expect(favorite).to respond_to(:user)
    end

    it "Photoに所属している" do
      favorite = Favorite.new
      expect(favorite).to respond_to(:photo)
    end
  end

  describe "重複登録" do
    it "同じユーザーが同じ写真をお気に入り登録できない" do
      user = User.create!(
        username: "favorite_test",
        email: "favorite_test@example.com",
        password: "password"
      )

      photo = Photo.create!(
        user: user,
        title: "テスト写真"
      )

      Favorite.create!(
        user: user,
        photo: photo
      )

      duplicate_favorite = Favorite.new(
        user: user,
        photo: photo
      )

      expect(duplicate_favorite).not_to be_valid
    end
  end
end