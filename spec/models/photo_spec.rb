require "rails_helper"

RSpec.describe Photo, type: :model do
  describe "関連付け" do
    it "Userに所属している" do
      photo = Photo.new
      expect(photo).to respond_to(:user)
    end

    it "撮影設定を1つ持っている" do
      photo = Photo.new
      expect(photo).to respond_to(:shooting_setting)
    end
  end
end