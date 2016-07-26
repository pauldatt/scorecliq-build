class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ManagersHelper
  private
  
  # The method confirms that a user is logged-in
  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = "Please sign-in to access this page."
      render 'static_pages/home'
    end
  end
  
  
  
end



