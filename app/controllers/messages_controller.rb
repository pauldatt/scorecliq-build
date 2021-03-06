class MessagesController < ApplicationController
    before_action :logged_in_user
    
    def create
     @user = User.find(params[:user_id])
     @conversation = Conversation.find(params[:conversation_id])
     @user_convo = @conversation.user_conversations.where(:user_id => current_user.id).first
     @message = @conversation.messages.build(message_params)
      if @message.save
         undeletion_unread
         redirect_to user_conversation_path(current_user, @user_convo)
      else
        redirect_to user_conversation_path(current_user, @user_convo)
        flash[:danger] = 'Message must be between 1-600 characters'
      end
    end
    
    private 
    
    def undeletion_unread
        @conversation.user_conversations.each do |c|
            if c.user != current_user
                if c.deleted == true
                    c.update_attributes(:deleted => "false")
                end
                c.update_attributes(:read => "true")
            end
            if c.user == current_user
                c.touch
            end
        end
    end
    
    
    def message_params
        params.require(:message).permit(:body).merge(user_id: current_user.id) 
    end
    
    
end
