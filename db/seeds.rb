# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Adminの作成
Admin.find_or_create_by(email: "admin123@gmail.com") do |user|
  user.password = "admin123"
end

# ジャンルの作成
[
  { name: 'ケーキ' },
  { name: 'プリン' },
  { name: '焼き菓子' },
  { name: 'キャンディ' }
].each do |genre|
  Genre.find_or_create_by!(genre)
end

# 商品の作成
[
  {
    name: 'クリスマスケーキ',
    introduction: 'クリスマスにぴったりのケーキです！',
    price: 3000,
    genre_id: Genre.find_by(name: 'ケーキ').id,
    is_active: true
  },
  {
    name: 'プリン',
    introduction: 'プリンです。',
    price: 500,
    genre_id: Genre.find_by(name: 'プリン').id,
    is_active: true
  },
  {
    name: 'クッキー',
    introduction: 'クッキーです。',
    price: 500,
    genre_id: Genre.find_by(name: '焼き菓子').id,
    is_active: true
  },
  {
    name: 'キャンディ',
    introduction: 'キャンディの詰め合わせです。',
    price: 1000,
    genre_id: Genre.find_by(name: 'キャンディ').id,
    is_active: true
  }
].each do |item|
  Item.find_or_create_by!(name: item[:name]) do |new_item|
    new_item.introduction = item[:introduction]
    new_item.price = item[:price]
    new_item.genre_id = item[:genre_id]
    new_item.is_active = item[:is_active]
  end
end

