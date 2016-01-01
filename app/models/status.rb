class Status < ActiveRecord::Base
  belongs_to :scoreboard
  
  validates :content, length: {maximum: 250}
end
