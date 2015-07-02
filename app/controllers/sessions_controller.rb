class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        render 'users/home' # Although it work, I am not sure if its a redirect or a render.
      else
        message = "Account not activated. "
        message += "Please check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'static_pages/home' # Same thing, not sure if i should redirect or render
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end


