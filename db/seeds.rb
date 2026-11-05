# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
techniques = [
  {
    name: "三分割法",
    category: "composition",
    description: "➤画面を縦横それぞれ3分割し、交点や線上に被写体を配置する構図"
  },
  {
    name: "日の丸構図",
    category: "composition",
    description: "➤被写体を画面の中央付近に配置する構図"
  },
  {
    name: "対角線構図",
    category: "composition",
    description: "➤被写体や線を画面の対角線上に配置する構図"
  },
  {
    name: "シンメトリー",
    category: "composition",
    description: "➤左右対称など、対称性を活かした構図"
  },
  {
    name: "逆光",
    category: "technique",
    description: "➤被写体の背後から光を当てて撮影する技法"
  },
  {
    name: "長時間露光",
    category: "technique",
    description: "➤シャッター速度を遅くして光や動きを表現する技法"
  },
  {
    name: "流し撮り",
    category: "technique",
    description: "➤動く被写体に合わせてカメラを動かし、背景を流して撮影する技法"
  },
  {
    name: "その他",
    category: "technique",
    description: "➤説明欄やコメント欄にて使用した構図を入力してください"
  }
]

techniques.each do |attributes|
  technique = Technique.find_or_initialize_by(name: attributes[:name])
  technique.update!(attributes)
end

# ==========================================
# サンプルユーザー
# ==========================================

user = User.find_by!(username: "torunto")

photo = Photo.find_or_initialize_by(
  user: user,
  title: "（例）光と森"
)

photo.update!(
  description: "（例）シャッタースピードを1/4秒にする長時間露光を使用し、木々の間から差し込む光を動的に見えるようにしました。",
  location: "福岡市"
)

photo_path = Rails.root.join("db/seeds/images/forest.png")

unless photo.image.attached?
  photo.image.attach(
    io: File.open(photo_path),
    filename: "forest.png",
    content_type: "image/png"
  )
end

photo_setting = ShootingSetting.find_or_initialize_by(photo: photo)

photo_setting.update!(
  aperture: "F8",
  iso: 100,
  shutter_speed: "1/4秒",
  focal_length: "50mm"
)

photo.techniques = [
  Technique.find_by!(name: "長時間露光"),
  Technique.find_by!(name: "逆光")
]

challenge = Challenge.find_or_initialize_by(
  user: user,
  reference_photo: photo,
  title: "（例）星降る夜"
)

challenge.update!(
  location: "北九州市",
  comment: "（例）参考写真の長時間露光を意識しながら、シャッタースピードを10秒にして星空をくっきりと映すことを意識しました。"
)

challenge_path = Rails.root.join("db/seeds/images/yozora.JPG")

unless challenge.image.attached?
  challenge.image.attach(
    io: File.open(challenge_path),
    filename: "yozora.JPG",
    content_type: "image/jpeg"
  )
end

challenge_setting = ShootingSetting.find_or_initialize_by(
  challenge: challenge
)

challenge_setting.update!(
  aperture: "F2.0",
  iso: 1600,
  shutter_speed: "10秒",
  focal_length: "24mm"
)

challenge.techniques = [
  Technique.find_by!(name: "長時間露光")
]

puts "サンプルデータの登録が完了しました！"