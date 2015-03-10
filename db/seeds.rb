# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Picture.delete_all
(1..7).each do |n|
  Picture.create(
    path: "/dummy_pictures/dummy#{n}.jpg",
    original_path: "/dummy#{n}_original.jpg",
    original_width: 1920,
    original_height: 1920
  )
end
