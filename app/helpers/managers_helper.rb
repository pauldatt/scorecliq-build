module ManagersHelper
    
  #the method confirms if you are a user OR an admin
  def manager_or_owner?(scoreboard, user)
     (user == scoreboard.user)||(scoreboard.managed_by.include?(user))
  end
  
  #scoreboard.user means you are the admin of the scoreboard
  #scoreboard.managed_by.include checks if the user is part of the managed by array.
  #if any one of the statement is true, you are either the owner or manager of the scoreboard
  #define @user in the controller as the user you get from the :user_id param you pass in the link
end
