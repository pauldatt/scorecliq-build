# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# end

User.create!(name:  "Divjot",
             email: "divjot@gmail.ca",
             password:              "foobar12",
             password_confirmation: "foobar12",
             activated: "true",
             admin: "true")

# 5.times do              
# Scoreboard.create!(name_of_scoreboard: "scoreboard_abc",
#                   name_of_organization: "abcdef",
#                   name_of_activity: "ghijklmn",
#                   user_id: 1,
#                   states: "state",
#                   country: "state",
#                   cities: "state")
# end


