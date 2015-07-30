class Scoreboard < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  #the picture uploader
  mount_uploader :picture, PictureUploader
  # Scoreboard information Validation
  validates :name_of_scoreboard, presence: true, length: { maximum: 50 }
  validates :name_of_organization, presence: true, length: { maximum: 50 } 
  validates :name_of_activity, presence:true, length: { maximum: 50 }
  validates :user_id, presence: true
  
  #Location and Period validations
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
  
   def self.search(search_term)
     where("name_of_organization LIKE ? or name_of_activity LIKE ? 
     or name_of_scoreboard LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%" )
   end
   
  
end
