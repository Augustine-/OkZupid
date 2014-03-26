# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tony = User.create(username: "Tony", species: "Tiger", password: "frosted")
sammy = User.create(username: "Sammy", species: "Snake", password: "parseltongue")
periwinkle = User.create(username: "Periwinkle", species: "Penguin", password: "northpole")