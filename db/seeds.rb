# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Kuljinder",
             email: "kuljinder_d@hotmail.com",
             password:              "otohime",
             password_confirmation: "otohime",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 99.times do |n|
#   name  = Faker::Name.name
#   email = "divjot-#{n+1}@example.com"
#   password = "password"
#   User.create!(name:  name,
#               email: email,
#               password:              password,
#               password_confirmation: password,
#               activated: true,
#               activated_at: Time.zone.now)

# 50000.times do

# Scoreboard.create!(name_of_scoreboard: "Bruce Wayne",
#                   name_of_organization: "League of Shadows",
#                   name_of_activity: "Saving Lives",
#                   states: "Ontario",
#                   country: "Canada",
#                   cities: "Brampton",
#                   user_id: 3)    
               
# Scoreboard.create!(name_of_scoreboard: "Wolverine",
#                   name_of_organization: "X Men",
#                   name_of_activity: "Ripping shit with Adamantium",
#                   states: "Ontario",
#                   country: "Canada",
#                   cities: "Brampton",
#                   user_id: 3)   

               
# Scoreboard.create!(name_of_scoreboard: "Joker",
#                   name_of_organization: "Gotham Villans",
#                   name_of_activity: "Why so serious",
#                   states: "Ontario",
#                   country: "Canada",
#                   cities: "Brampton",
#                   user_id: 3)   
                   
# Scoreboard.create!(name_of_scoreboard: "Quicksilver",
#                   name_of_organization: "X-Men",
#                   name_of_activity: "Slick, fast and cool",
#                   states: "Ontario",
#                   country: "Canada",
#                   cities: "Brampton",
#                   user_id: 3)  
                   
# Scoreboard.create!(name_of_scoreboard: "IronMan",
#                   name_of_organization: "Marvel Comics",
#                   name_of_activity: "Being a bad ass",
#                   states: "Ontario",
#                   country: "Canada",
#                   cities: "Brampton",
#                   user_id: 3)  
                   

