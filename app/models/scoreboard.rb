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
  
  
   # Multisearch method for scoreboard
   include PgSearch
   multisearchable :against => [:name_of_organization, :name_of_activity, :name_of_scoreboard ]
   
   PgSearch.multisearch_options = {
  :using => {
              :tsearch => {
                 :prefix => true,
                 :dictionary => "english",
                 :any_word => true
               }
            }
  }
   
   
   
  
end
