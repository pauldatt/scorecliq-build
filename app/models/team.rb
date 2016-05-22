class Team < ActiveRecord::Base
  before_save :auto_fill_team
  
  belongs_to :scoreboard
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :scoreboard_id, presence: true
  
  # each team could have many members(users) through team members, this gives us all the members associated with a team
  has_many :team_members
  has_many :members, through: :team_members, source: :user, dependent: :destroy 
  
  #the following code differentiates between captains and normal users 
  has_many :captains, -> { where(team_members: {captain: true}) }, through: :team_members, source: :user, dependent: :destroy
  has_many :non_captains, -> { where(team_members: {captain: false}) }, through: :team_members, source: :user, dependent: :destroy
  
  #self reference with the teams to create team_matches. Each team acts as a facing team or an opposing team.
  has_many :first_team, class_name: "TeamMatch", foreign_key: "team_a_id", dependent: :destroy #the facing_team is acting as the home_team
  has_many :team_a, through: :first_team, source: :team_a
  
  has_many :second_team, class_name: "TeamMatch", foreign_key: "team_b_id", dependent: :destroy #the opposing team is acting as the away team
  has_many :team_b, through: :second_teams, source: :team_b
  
  
  private
  
  def auto_fill_team
    
    if self.win.blank?
      self.win = "0"
    end
    
    if self.loss.blank?
      self.loss="0"
    end 
    
    if self.tie.blank?
      self.tie="0"
    end
    
  end
  
end
