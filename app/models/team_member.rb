class TeamMember < ActiveRecord::Base

    belongs_to :user # each user could be part of many teams as a member
    belongs_to :team # each team could have many users as members
    
    validates :user_id, presence: true
    validates :team_id, presence: true
end
