class User < ActiveRecord::Base
  # each user can creare many scoreboards
  has_many :scoreboards, dependent: :destroy
  
  # each user can create comments to a scoreboard
  has_many :comments, dependent: :destroy
  
  #sets up the relationship with the join table
  has_many :favourites
  
  #allows you to access the favourite scoreboards associated with the user
  has_many :favourite_scoreboards, through: :favourites, source: :scoreboard
  
  #the mailboxer gem is being accessed by the following code
  acts_as_messageable
  
  #the following is an attempt at message length validation
  validates :body, presence: true, length: { maximum: 50 }
  
  has_many :friendships
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  
  has_many :active_friends, -> { where(friendships: {approved: true}) }, :through => :friendships, :source => :friend 
  has_many :passive_friends, -> { where(friendships: {approved: true}) }, :through => :passive_friendships, :source => :user
  has_many :pending_friends, -> { where(friendships: {approved: false}) }, :through => :friendships, :source => :friend
  has_many :requested_friendships, -> { where(friendships: {approved: false}) }, :through => :passive_friendships, :source => :user
  
  # each user has one picture
  has_one :picture, as: :pictureable
  
  def friends
    active_friends | passive_friends
  end

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email 
  before_create :create_activation_digest 
  before_validation :strip_whitespace, :only => [:name, :email] 
  validates :name, presence: true, length: { maximum: 50 } 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  
  # Returns the hash digest of the given string
  def User.digest(string) # (string) is a user object
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Generates a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the databse for use in sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token)) #update the remember digest with the remember token 
  end
  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil) #update the remember digest with nil, so it forgets the user
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at,    Time.zone.now)
  end
  
  # It sends an activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # Sends password reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Method for expiring password resets
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def self.search(search_term)
    where("name LIKE ?", "%#{search_term}%") 
  end
  
  
  private 
  
    # Converts email to all lower-case
    def downcase_email
      self.email = email.downcase
    end
    
    # Creates and assigns the activation token and digest
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
    def strip_whitespace
      self.name = self.name.strip
      self.email = self.email.strip
    end
    
    
    #this should work for the mailboxer gem to get email from the user 
    def mailboxer_email(user)
    return email 
    end
    
    #Mulisearch method for user
    include PgSearch
    multisearchable :against => :name
  
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
    


      

# The method gets defined in the user models. Then they get written in the sessions helper,
# Once they are in the session helper they can get used by the sessions controller.




