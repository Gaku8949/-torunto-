require 'rails_helper'

RSpec.describe "pages/terms.html.erb", type: :view do
  it "利用規約のタイトルが表示されること" do
    render

    expect(rendered).to include("TORUNTO 利用規約")
  end

  it "すべての条文の見出しが表示されること" do
    render

    (1..13).each do |number|
      expect(rendered).to include("第#{number}条")
    end
  end

  it "サービスの主な機能が表示されること" do
    render

    expect(rendered).to include("写真の投稿および閲覧")
    expect(rendered).to include("撮影チャレンジ機能")
    expect(rendered).to include("コメントおよびお気に入り登録")
  end

  it "制定日と運営者が表示されること" do
    render

    expect(rendered).to include("制定日")
    expect(rendered).to include("運営者：TORUNTO")
  end
end