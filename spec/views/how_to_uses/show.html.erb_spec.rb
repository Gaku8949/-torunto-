require 'rails_helper'

RSpec.describe "how_to_uses/show.html.erb", type: :view do
  it "TORUNTOの使い方の画像が表示されること" do
    render

    expect(rendered).to include("<img")
    expect(rendered).to include("how-to-use-image")
    expect(rendered).to include("TORUNTOの使い方")
  end
end