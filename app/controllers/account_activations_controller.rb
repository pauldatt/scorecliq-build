class AccountActivationsController < ApplicationController
  
def edit
  user = User.find_by(:email, params[:email])
  if user && !user.activated? && user.authenticated?(:activation, params[:id]) #the token is actually available by params id
    user.activate
    log_in user
    flash[:success] = "Account activated."
    redirect_to home_path
  else
    flash[:danger] = "Invalid activation link"
    redirect_to root_url
  end
end


end



