class Scoreboard < ActiveRecord::Base
  belongs_to :user
  has_many :teams, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  
  # The picture uploader
  mount_uploader :picture, PictureUploader
  
  # Scoreboard information Validation
  validates :name_of_scoreboard, presence: true, length: { maximum: 50 }
  validates :name_of_organization, presence: true, length: { maximum: 50 } 
  validates :name_of_activity, presence:true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :status, length: {maximum: 255}
  
  # Profile pic validations
  validate :picture_size
  
  #Location and Period validations
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
   # Temporary search bar method
   def self.search(search_term)
     where("name_of_organization LIKE ? or name_of_activity LIKE ? 
     or name_of_scoreboard LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%" )
   end
   
   private
   
   #validate size of profile picture in terms of mb
   def picture_size 
     if picture.size > 5.megabytes
       errors.add(:picture, "should be less than 5MB")
     end
   end
   
  
end
