class Comment < ActiveRecord::Base
  
  has_ancestry 
  # each comment is created by a user
  belongs_to :user
  # each comment is attached to a scoreboard
  belongs_to :scoreboard
  
  
 validates :body, presence: true, length: { maximum: 140 }
 
end
