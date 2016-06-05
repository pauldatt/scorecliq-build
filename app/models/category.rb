class Category < ActiveRecord::Base
  belongs_to :scoreboard
  
  #each categories can potentially have many documents uploaded
  has_many :documents, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: 40}
  
end
