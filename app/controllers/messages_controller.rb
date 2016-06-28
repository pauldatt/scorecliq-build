class MessagesController < ApplicationController
    before_action :logged_in_user
    
    def create
     @conversation = Conversation.find(params[:conversation_id])
     @message = @conversation.messages.build(message_params)
      if @message.save
         undeletion_unread
         redirect_to :back
         flash[:success] = "Message Sent Successfully"
      else
        redirect_to :back
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
                if c.read == (false || nil )
                    c.update_attributes(:read => "true")
                end
            end
        end
    end
    

    
    def message_params
        params.require(:message).permit(:body).merge(user_id: current_user.id) 
    end
end
