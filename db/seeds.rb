# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Divjot",
             email: "divjot65@gmail.com",
             password:              "otohime",
             password_confirmation: "otohime",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 100.times do

# Scoreboard.create!(name_of_scoreboard: "Bruce Wayne",
#                   name_of_organization: "League of Shadows",
#                   name_of_activity: "Saving Lives",
#                   states: "Ontario",
#                   country: "Canada",
#                   cities: "Brampton",
#                   user_id: 1 )
                     
               
# Scoreboard.create!(name_of_scoreboard: "Wolverine",
#                   name_of_organization: "X Men",
#                   name_of_activity: "Ripping shit with Adamantium",
#                   states: "Ontario",
#                   country: "Canada",
#                   cities: "Brampton",
#                   user_id: 1)

                   
# end

