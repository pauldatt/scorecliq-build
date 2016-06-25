# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)

# end

# User.create!(name:  "Divjot",
#              email: "divjot@gmail.ca",
#              password:              "foobar12",
#              password_confirmation: "foobar12",
#              activated: "true",
#              admin: "true")

200.times do              
Scoreboard.create!(name_of_scoreboard: "league of shadows",
                  name_of_organization: "Undeground assins",
                  name_of_activity: "Traning batman to protect gotham",
                  user_id: 1,
                  states: "NY",
                  country: "USA",
                  cities: "Gotham")

Scoreboard.create!(name_of_scoreboard: "X-men",
                  name_of_organization: "Mutants Unite",
                  name_of_activity: "Fighting Evil",
                  user_id: 1,
                  states: "NY",
                  country: "USA",
                  cities: "Gotham")

Scoreboard.create!(name_of_scoreboard: "Gotham",
                  name_of_organization: "Arkham Asylum",
                  name_of_activity: "Traning batman to protect gotham",
                  user_id: 1,
                  states: "NY",
                  country: "USA",
                  cities: "Gotham")
                  
Scoreboard.create!(name_of_scoreboard: "testing for optimization",
                  name_of_organization: "test test test",
                  name_of_activity: "ya ya y ay ay aya ya ay",
                  user_id: 1,
                  states: "NY",
                  country: "USA",
                  cities: "Gotham")

Scoreboard.create!(name_of_scoreboard: "hand sanitizer",
                  name_of_organization: "purel is the best",
                  name_of_activity: "killing germs at hand",
                  user_id: 1,
                  states: "NY",
                  country: "USA",
                  cities: "Gotham")

end


