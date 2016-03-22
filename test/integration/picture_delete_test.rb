require 'test_helper'

class PictureDeleteTest < ActionDispatch::IntegrationTest
  
  def setup 
    @pictureable_s = scoreboards(:scoreboard_a) #picture_a is associated with scoreboard_a
    @picture_s = @pictureable_s.picture #this is the picture associated with the pictureable (scoreboard_a)
    @scoreboard = scoreboards(:scoreboard_a) #pictureable is scoreboard_a
    
    @pictureable_u = users(:divjot)
    @picture_u = @pictureable_u.picture
    @user = users(:divjot)
  end
  
  test "successfuly deleting a picture if pictureable is scoreboard" do
    delete scoreboard_picture_path(@scoreboard, @pictureable_s)
    assert_equal "Picture removed successfully", flash[:success]
  end
  
  test "successfuly deleting a picture if pictureable is a user" do
    delete user_picture_path(@user, @pictureable_u)
    assert_equal "Picture removed successfully", flash[:success]
  end
  
  
end
