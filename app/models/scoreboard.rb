class Scoreboard < ActiveRecord::Base
  before_create :associate_status

  # each scoreboard is created by a user
  belongs_to :user
  
  # each scoreboard has many teams
  has_many :teams, dependent: :destroy
  
  # each scoreboard has_many comments
  has_many :comments, dependent: :destroy
  
  # sets up the relationship with the favourites(join) table
  has_many :favourites, dependent: :destroy
 
  #allows you to access the users associated with the favourited scoreboards
  has_many :favourited_by, through: :favourites, source: :user, dependent: :destroy
  
  #each scoreboard can have many schedules on it 
  has_many :schedules, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  
  #each scoreboard has one picture
  has_one :picture, as: :pictureable
  
  #each scoreboard has one status
  has_one :status, dependent: :destroy
  
  def associate_status
      self.build_status(:content => "Click here to upload Status")
  end
  
  # Scoreboard information Validation
  validates :name_of_scoreboard, presence: true, length: { maximum: 50 }
  validates :name_of_organization, presence: true, length: { maximum: 50 } 
  validates :name_of_activity, presence:true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :status, length: {maximum: 255}
  
  
  #Location and Period validations
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
   # Temporary search bar method
   def self.search(search_term)
     where("name_of_organization LIKE ? or name_of_activity LIKE ? 
     or name_of_scoreboard LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%" )
   end
   
   
  
end
