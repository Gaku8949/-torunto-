# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Technique.create!([
  {
    name: "三分割法",
    category: "composition",
    description: "画面を縦横それぞれ3分割し、交点や線上に被写体を配置する構図"
  },
  {
    name: "日の丸構図",
    category: "composition",
    description: "被写体を画面の中央付近に配置する構図"
  },
  {
    name: "対角線構図",
    category: "composition",
    description: "被写体や線を画面の対角線上に配置する構図"
  },
  {
    name: "シンメトリー",
    category: "composition",
    description: "左右対称など、対称性を活かした構図"
  },
  {
    name: "逆光",
    category: "technique",
    description: "被写体の背後から光を当てて撮影する技法"
  },
  {
    name: "長時間露光",
    category: "technique",
    description: "シャッター速度を遅くして光や動きを表現する技法"
  },
  {
    name: "流し撮り",
    category: "technique",
    description: "動く被写体に合わせてカメラを動かし、背景を流して撮影する技法"
  }
])