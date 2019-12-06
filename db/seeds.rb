# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.destroy_all

team_names = [
  "Zenith",
  "IkaRus",
  "Team Olive",
  "Black Squid Ink Burger (BSIB)",
  "Kagura",
  "Red Ink",
  "Squid Alpine",
  "Hxagon"
]

team_names.each do |team_name|
  Team.create(name: team_name)
end

puts "Seeded"
puts Team.all
