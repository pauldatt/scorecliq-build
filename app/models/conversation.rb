class Conversation < ActiveRecord::Base
    has_many :user_conversations
    has_many :users, through: :user_conversations, dependent: :destroy
    has_many :messages, dependent: :destroy
    
    accepts_nested_attributes_for :messages
    
    validates :subject, presence: true, length: { maximum: 80 }
end

