class Invitation < ActiveRecord::Base
  #Each sent_invitation belongs to a sender, this is the user acting as the sender
  
  belongs_to :sender, :class_name => "scoreboard"
  
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :recipient_email, presence: true, length: { maximum: 255 },
                    #format: { with: VALID_EMAIL_REGEX },
                    #case_sensitive: false 
                    
                    
  
                    
end
