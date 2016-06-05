ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  # Logging in as a test user
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password1'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end
  
  def is_correct_user?
    scoreboards(:scoreboard_a).user #this user is divjot in yml file.
  end
  
  
  private
  
    # Returns true inside an integration tests.
    def integration_test?
      defined?(post_via_redirect)
    end
    
    def current_user
    if (user_id = session[:user_id]) #Retrieving the user from the temprary sessions
      @current_user ||= User.find_by(id: user_id) 
    elsif (user_id = cookies.signed[:user_id]) #Retrieving the user from the cookies sessions
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    end
    
    
    
   
end


