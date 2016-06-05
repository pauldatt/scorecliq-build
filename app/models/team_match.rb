class TeamMatch < ActiveRecord::Base
   
    belongs_to :team_a, class_name: "Team"
    belongs_to :team_b, class_name: "Team"
    belongs_to :scoreboard 
    validates :team_a_id, presence: { message: 'has not been selected.' }
    validates :team_b_id, presence: { message: 'has not been selected.' }
    validates :match_date, presence: true
    validates :score, length: {maximum: 25}
    validates :location, length: {maximum: 40}
    
    #the following scope is used to narrow down team-matches based on a team selection
    scope :has_team, ->(team_id) {
        team_a = arel_table[:team_a_id].eq(team_id)
        team_b = arel_table[:team_b_id].eq(team_id)
        team_a_or_b = team_a.or(team_b)
    
        where(team_a_or_b)
    }
end
