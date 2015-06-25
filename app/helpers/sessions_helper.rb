module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id # The method places a temprary session cookie on the user's broswer
  end
  
  # Remembers a user in a persistent session.
  def remember(user) # this generates a remember token and saves its digest to the database. 
    user.remember    # It was defined in the user's model
    cookies.permanent.signed[:user_id] = user.id # This stores the user.ID(encrypted) in the browser cookie
    cookies.permanent[:remember_token] = user.remember_token # This stores the remember token(encrypted) in the cookie
  end
  
  # Returns true if the user is the current user
  def current_user?(user)
    user == current_user
  end
  
  # Returns the current logged-in user (if any)
  # Once the ID is placed on the user's browser, we find the user using the encrypted ID. 
  def current_user
    if (user_id = session[:user_id]) #Retrieving the user from the temprary sessions
      @current_user ||= User.find_by(id: user_id) 
    elsif (user_id = cookies.signed[:user_id]) #Retrieving the user from the cookies sessions
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # Returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end
  
   # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
  # This redirects to the stored location 
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
end
