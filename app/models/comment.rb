class Comment < ActiveRecord::Base

  has_ancestry 
  # each comment is created by a user
  belongs_to :user
  # each comment is attached to a topic
  belongs_to :topic
  
  
  validates :body, presence: true, length: { maximum: 600 }
  # validates :user_id, :presence => true

  scope :no_ancestry, -> { where(ancestry: nil) }
  
end


