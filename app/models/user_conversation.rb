class UserConversation < ActiveRecord::Base
    belongs_to :user
    belongs_to :conversation
    has_many :messages, through: :conversation
    
    accepts_nested_attributes_for :conversation
    
    delegate :subject, to: :conversation 
    delegate :users, to: :conversation
    
    #this method will create all the neccessary through associations between the conversation and user
    attr_accessor :recipient_id
    before_create :create_user_conversations
    
    private 
    
    def create_user_conversations
        return if recipient_id.blank?
        UserConversation.create :user_id => recipient_id, :conversation => conversation
    end
    
end
