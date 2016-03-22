require 'test_helper'

class ScoreboardIndexTest < ActionDispatch::IntegrationTest
 
 def setup
   @user = users(:divjot)
   @scoreboard = scoreboards(:scoreboard_a)
 end
 
 test 'scoreboard index as a logged in user and when the scoreboard is created' do
   log_in_as(@user) do
     get scoreboards_path #scoreboards index page 
     assert_select "a[href=?]", scoreboard_path(@scoreboard), count: 1 #show page, the link of the scoreboard name
     assert_select "a[href=?]", edit_scoreboard_path(@scoreboard), count: 1 #edit
     assert_difference('Scoreboard.count', -1) do #the delete functionality
       delete :destroy, id: @scoreboard.id
     end
   end
 end
 
 
end

 
