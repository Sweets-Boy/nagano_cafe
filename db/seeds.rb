# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.find_or_create_by(email: "admin123@gmail.com") do |user|
  user.password = "admin123"  # 必要な場合のみ設定
end

Genre.create!([
  { name: 'ケーキ' },
  { name: 'プリン' },
  { name: '焼き菓子' },
  { name: 'キャンディ' }
])

Item.create!([
  {
    name: 'クリスマスケーキ',
    introduction: 'クリスマスにぴったりのケーキです！',
    price: 3000,
    genre_id: Genre.find_by(name: 'ケーキ').id, # ジャンルを指定
    is_active: true
  },
  {
    name: 'プリン',
    introduction: 'プリンです。',
    price: 500,
    genre_id: Genre.find_by(name: 'プリン').id, # ジャンルを指定
    is_active: true
  },
  {
    name: 'クッキー',
    introduction: 'クッキーです。',
    price: 500,
    genre_id: Genre.find_by(name: '焼き菓子').id, # ジャンルを指定
    is_active: true
  },
  name: 'キャンディ',
  introduction: 'キャンディの詰め合わせです。',
  price: 1000,
  genre_id: Genre.find_by(name: 'キャンディ').id, # ジャンルを指定
  is_active: true
])
