require 'rails_helper'

RSpec.describe "profiles/show.html.erb", type: :view do
  before do
    assign(:user, build(:user, username: "test_user", email: "test@example.com"))
    assign(:photo_count, 0)
    assign(:challenge_count, 0)
    assign(:photos, [])
    assign(:challenges, [])
    assign(:favorite_photos, [])
    assign(:favorite_challenges, [])
  end

  it "プロフィールのタイトルが表示されること" do
    render

    expect(rendered).to include("プロフィール")
  end

  it "ユーザー名とメールアドレスが表示されること" do
    render

    expect(rendered).to include("test_user")
    expect(rendered).to include("test@example.com")
  end

  it "写真とチャレンジの投稿数が表示されること" do
    render

    expect(rendered).to include("投稿した写真")
    expect(rendered).to include("チャレンジした写真")
  end

  it "3種類のタブが表示されること" do
    render

    expect(rendered).to include('data-tab="photos"')
    expect(rendered).to include('data-tab="challenges"')
    expect(rendered).to include('data-tab="favorites"')
  end

  it "投稿がない場合に案内メッセージが表示されること" do
    render

    expect(rendered).to include("まだ写真を投稿していません。")
    expect(rendered).to include("まだチャレンジした写真がありません。")
    expect(rendered).to include("まだお気に入りした写真がありません。")
  end
end