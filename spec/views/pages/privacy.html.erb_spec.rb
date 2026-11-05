require 'rails_helper'

RSpec.describe "pages/privacy.html.erb", type: :view do
  it "プライバシーポリシーの内容が表示されること" do
    render

    expect(rendered).to include("TORUNTO プライバシーポリシー")
    expect(rendered).to include("第1条（基本方針）")
    expect(rendered).to include("第2条（取得する情報）")
    expect(rendered).to include("第3条（個人情報の利用目的）")
    expect(rendered).to include("第4条（投稿情報の公開）")
    expect(rendered).to include("第11条（お問い合わせ窓口）")
  end
end