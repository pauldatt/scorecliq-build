class Favourite < ActiveRecord::Base
    belongs_to :user
    belongs_to :scoreboard
    validates :user_id, presence: true
    validates :scoreboard_id, presence: true
end
