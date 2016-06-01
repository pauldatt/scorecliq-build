class Topic < ActiveRecord::Base
  belongs_to :scoreboard
  
  validates :subject, presence: true, length: {maximum: 30}
  
end
