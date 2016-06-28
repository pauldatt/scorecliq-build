# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# end

# User.create!(name:  "khalesi",
#              email: "khalesi@gmail.com",
#              password:              "1dragons",
#              password_confirmation: "1dragons",
#              activated: "true",
#              admin: "true")

1.times do
    Message.create!(body: "this is a message",
                    user_id: 1,
                    conversation_id: 16)
    
    Message.create!(body: "this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.
                          this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.
                          this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.this message is possibly by swag.",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "4",
                    user_id: 6613,
                    conversation_id: 16)
    
    Message.create!(body: "5",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "6",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "7",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "8",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "9",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "10",
                    user_id: 6613,
                    conversation_id: 16)
    
    Message.create!(body: "11",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "12",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "13",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "14",
                    user_id: 6613,
                    conversation_id: 16)
                    
    Message.create!(body: "15",
                    user_id: 6613,
                    conversation_id: 16)
end

#kjnkn
# 30.times do 
# Comment.create!(body: "kuljinder is skinny, enough said!",
#                 user_id: 1,
#                 topic_id: 40,)
# Comment.create!(body: "Iskara lawrence is bae, bhabi a teri kuljinder.",
#                 user_id: 1,
#                 topic_id: 40,)
# Comment.create!(body: "All the PRETTY girls are kuljinders bhabis, cause by deafult they belong to me",
#                 user_id: 1,
#                 topic_id: 40,)
# Comment.create!(body: "Baneet is the LARGEST piece of shit ever",
#                 user_id: 1,
#                 topic_id: 40,)
# Comment.create!(body: "Baneet is fat ugly and stinks. Still better than kuljinder",
#                 user_id: 1,
#                 topic_id: 40,)
# end


