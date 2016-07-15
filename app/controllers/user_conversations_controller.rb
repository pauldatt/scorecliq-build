class UserConversationsController < ApplicationController
    before_action :logged_in_user
    before_action :validate_conversation, only: :create
    before_action :conversation_security, only: :show
    
    def index
        @convos = current_user.user_conversations.where('deleted = ? OR deleted IS ?', false, nil).order("updated_at DESC")
        @conversations = @convos.paginate(page: params[:page], per_page: 10)
        @convopage = true
    end
    
    def new 
        redirect_to home_path unless current_user
        
        @user = User.find(params[:user_id])
        @conversation = @user.user_conversations.build
        @conversation.build_conversation.messages.build
        @convopage = true
    end
    
    def create
         redirect_to home_path unless current_user
         @conversation = UserConversation.new conversation_params
         @conversation.user = current_user
         @conversation.conversation.messages.first.user = current_user
         @conversation.save!
         activate_unread
         redirect_to user_conversation_path(current_user, @conversation)
    end
    
    def show
        @conversation = UserConversation.find params[:id]
        @conversation.update_columns(read: "false")
        @messages = @conversation.messages.order("created_at DESC").paginate(page: params[:page], per_page: 20)
        @message = Message.new
        @convopage = true
        respond_to do |format|
            format.html
            format.js
        end
    end
    
    def deletion
        @user = User.find(params[:user_id])
        @user_conversation = UserConversation.find(params[:id])
        #if this path is available that means that deleted boolean must be false 
        @user_conversation.update_attributes(:deleted => "true")
        redirect_to user_conversations_path(current_user)
        flash[:success] = "The conversation was successfully deleted."
    end
    
    private 
    
    def conversation_params
        params.require(:user_conversation).permit(:recipient_id, conversation_attributes: [:subject, messages_attributes: [:body]])
    end
    
    def validate_conversation
        @user = User.find params[:user_id]
        if params[:user_conversation][:conversation_attributes]["subject"].blank? 
            redirect_to new_user_conversation_path(@user)
            flash[:danger] = "Subject cannot be blank"
        elsif params[:user_conversation][:conversation_attributes][:messages_attributes]["0"]["body"].blank?
            redirect_to new_user_conversation_path(@user)
            flash[:danger] = "Message cannot be blank"
        end
    end
    
    def activate_unread
        @convo = @conversation.conversation
        @convo.user_conversations.each do |c|
            if c.user != current_user
                if c.read == (false || nil)
                    c.update_attributes(:read => "true")
                end
            end
        end
    end
    
    def conversation_security
      @conversation = UserConversation.find params[:id]
      if current_user != @conversation.user 
          flash[:danger] = "Access Denied! You can't access other's messages."
          redirect_to user_conversations_path(current_user)
      end
    end
    
end
