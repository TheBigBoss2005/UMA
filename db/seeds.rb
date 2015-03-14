# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
[
  { name: '19861115', icon: 'https://avatars2.githubusercontent.com/u/7549216?v=3&s=400' },
  { name: 'ken-aio', icon: 'https://avatars1.githubusercontent.com/u/3462833?v=3&s=460' }
].each do |user|
  User.create(user)
end
Picture.delete_all
(1..7).each do |n|
  Picture.create(
    path: "/dummy_pictures/dummy#{n}.jpg",
    iine_count: 0,
    total_count: 0,
    choosed: false,
    date: '2015/04/01',
    original_path: "/dummy#{n}_original.jpg",
    original_width: 1920,
    original_height: 1920
  )
end
