class MessagesController < ApplicationController
  #before_action :authenticate_user! same as the conversation controller. this
  #will need to be edited to reflect the authentication method we made 

  def new
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
  
  
end

