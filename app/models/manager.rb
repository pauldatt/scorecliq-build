class Manager < ActiveRecord::Base
    belongs_to :scoreboard
    belongs_to :user
    
    validates :scoreboard_id, presence: true
    validates :user_id, presence: true
end
