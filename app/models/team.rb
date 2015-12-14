class Team < ActiveRecord::Base
  before_save :auto_fill_team
  
  belongs_to :scoreboard
  
  validates :name, presence: true, length: { maximum: 30 }
  
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
