class MessagesController < ApplicationController
  #before_action :authenticate_user! same as the conversation controller. this
  #will need to be edited to reflect the authentication method we made 
  before_action :validate_message_length, only: [:create]
  
  before_action :logged_in_user, only: [:create]
  
  def new
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
  
  private
  
  def validate_message_length
    if params[:message][:body].length > 10
      flash[:success] ="Message length too long"
      redirect_to new_message_path
    end
  end
  
end

