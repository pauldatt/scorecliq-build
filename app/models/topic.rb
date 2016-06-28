class Topic < ActiveRecord::Base

  belongs_to :scoreboard
  belongs_to :user
  has_many   :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
  
  validates :subject, presence: true, length: {maximum: 80}
  
end
