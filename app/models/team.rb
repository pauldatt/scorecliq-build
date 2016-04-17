class Team < ActiveRecord::Base
  before_save :auto_fill_team
  
  belongs_to :scoreboard
  
  validates :name, presence: true, length: { maximum: 34 }
  validates :scoreboard_id, presence: true
  
  # each team could have many members(users) through team members, this gives us all the members associated with a team
  has_many :team_members
  has_many :members, through: :team_members, source: :user, dependent: :destroy
  
  #self reference with the teams to create team_matches. Each team acts as a facing team or an opposing team.
  has_many :facing_teams, class_name: "team_match", foreign_key: "home_team_id", dependent: :destroy #the facing_team is acting as the home_team
  has_many :home_team, through: :facing_teams, source: :home_team, dependent: :destroy
  
  has_many :opposing_teams, class_name: "team_match", foreign_key: "away_team_id", dependent: :destroy #the opposing team is acting as the away team
  has_many :away_team, through: :opposing_teams, source: :away_team, dependent: :destroy
  
  
  private
  
  def auto_fill_team
    if self.win.blank?
      self.win ="0"
    end
    
    if self.loss.blank?
      self.loss="0"
    end 
    
    if self.tie.blank?
      self.tie="0"
    end
    
  end
  
end
