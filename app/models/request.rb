class Request < ActiveRecord::Base
    belongs_to :user #each user can request to join many scoreboards
    belongs_to :scoreboard #each scoreboard could be requested by many users
    
    validates :user_id, presence: true
    validates :scoreboard_id, presence: true
end
