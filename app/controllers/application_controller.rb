class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def hello
    render text: "hello world, This is Div and this will be my first live application, you made it this far, keep going, you got it!!"
  end
end
