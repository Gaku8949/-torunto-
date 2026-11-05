require 'rails_helper'

RSpec.describe "techniques/show.html.erb", type: :view do
  before do
    assign(:technique, build(
      :technique,
      name: "長時間露光",
      description: "シャッタースピードを遅くして撮影する技法です。"
    ))
  end

  it "技法名が表示されること" do
    render

    expect(rendered).to include("長時間露光")
  end

  it "技法の説明が表示されること" do
    render

    expect(rendered).to include("シャッタースピードを遅くして撮影する技法です。")
  end

  it "写真投稿に戻るリンクが表示されること" do
    render

    expect(rendered).to include("写真投稿に戻る")
    expect(rendered).to include(new_photo_path)
  end
end