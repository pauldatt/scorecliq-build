class TeamMatch < ActiveRecord::Base
   
    belongs_to :team_a, class_name: "Team"
    belongs_to :team_b, class_name: "Team"
    belongs_to :scoreboard 
    validates :team_a_id, presence: { message: 'has not been selected.' }
    validates :team_b_id, presence: { message: 'has not been selected.' }
    validates :match_date, presence: true
    validates :score, length: {maximum: 25}
    validates :location, length: {maximum: 40}
end
