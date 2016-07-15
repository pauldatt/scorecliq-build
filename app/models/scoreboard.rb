class Scoreboard < ActiveRecord::Base

  # before_create method for status
  before_create :associate_status
  
  # the method that build the association with the status as soon as it is saved
  def associate_status
      self.build_status(:content => "Click here to upload league Status")
  end
  
  # *************////// Below are all the association with the scoreboards //////*************
  
  # each scoreboard is created by a user
  belongs_to :user
  
  # each scoreboard has_many teams
  has_many :teams, dependent: :destroy
  
  # sets up the relationship with the favourites(join) table
  has_many :favourites, dependent: :destroy
 
  #allows you to access the users associated with the favourited scoreboards
  has_many :favourited_by, through: :favourites, source: :user, dependent: :destroy #the source user would look for foreign key user_id
  
  #The scoreboard thats created last shows up first
  default_scope -> { order(created_at: :desc) }
  
  #each scoreboard has one picture
  has_one :picture, as: :pictureable, dependent: :destroy
  
  #each scoreboard has one status
  has_one :status, dependent: :destroy
  
  #each scoreboard has_many events
  has_many :events, dependent: :destroy
  
  #each scoreboard could be requested_by many users
  has_many :requests, dependent: :destroy
  
  has_many :requested_by, through: :requests, source: :user, dependent: :destroy
  
  has_many :pending_requests, -> { where(requests: {approved: false}) }, through: :requests, source: :user, dependent: :destroy
  
  
  #each scoreboard could have managers(admins)
  has_many :managers, dependent: :destroy
  
  has_many :managed_by, through: :managers, source: :user, dependent: :destroy
  
  has_many :categories, dependent: :destroy
  
  has_many :team_matches, dependent: :destroy
  
  has_many :topics, dependent: :destroy
  
  # *************////// Below are all the validations on the scoreboard columns //////*************
  
  # Scoreboard information Validation
  validates :name_of_scoreboard, presence: true, length: { maximum: 70 }
  validates :name_of_organization, presence: true, length: { maximum: 50 } 
  validates :name_of_activity, presence: true, length: { maximum: 45 }
  validates :location, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  
   # *************////// Below is the search method for scoreboard and searching associations //////*************
   
  include PgSearch
      
  pg_search_scope :search_by_scoreboard, 
                    :against => [:name_of_scoreboard, :name_of_organization, :name_of_activity, :location],
                    :using => {
                        :tsearch => {
                            tsvector_column: "tsv",
                            :prefix => true,
                            :dictionary => "english",
                            :any_word => true
                        }
                    
                    }
   
end
