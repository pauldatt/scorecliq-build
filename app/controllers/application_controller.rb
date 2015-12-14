class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  
  # The method confirms that a user is logged-in
  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "Please sign-in to access this page."
      render 'static_pages/home'
    end
  end
  
  #this method is one of the ones added to help out if a resource is not found 
  #while initially added for mailboxer, this could work for anything
  rescue_from ActiveRecord::RecordNotFound do
   flash[:warning] = 'Resource not found.'
   redirect_back_or root_path #root path occurs when referer field is not valid
  end

   #this method works in conjunction with rescue_from in order to make redirects
  def redirect_back_or(path)
   redirect_to request.referer || path
  end
  
  
end



