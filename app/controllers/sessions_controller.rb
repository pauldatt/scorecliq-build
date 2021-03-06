class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or home_path #the methods are written in sessions helper for friendly forwarding
      else
        message = "Account not activated."
        message += "Please check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
    else
       flash[:danger] = "Invalid email/password combination"
       redirect_to root_url
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end




