class Schedule < ActiveRecord::Base
  before_save :auto_fill_schedule
  
  belongs_to :scoreboard
  
  validates :team1, presence: true, length: { maximum: 35 }
  validates :team2, presence: true, length: { maximum: 35 }
  validates :match_date, presence: true
  validates :match_time, length: { maximum: 8 }
  validates :detail, length: { maximum: 30 }
  
  def auto_fill_schedule
    if self.match_time.blank?
      self.match_time ="N/A"
    end
    
    if self.detail.blank?
      self.detail="N/A"
    end 
  end
  
end
