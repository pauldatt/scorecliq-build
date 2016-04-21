require 'test_helper'

class PictureUpdateTest < ActionDispatch::IntegrationTest
  
  def setup
    @pictureable_s = scoreboards(:scoreboard_a) #picture_a is associated with scoreboard_a
    @picture_s = @pictureable_s.picture #this is the picture associated with the pictureable (scoreboard_a)
    @scoreboard = scoreboards(:scoreboard_a) #pictureable is scoreboard_a
    
    @pictureable_u = users(:divjot)
    @picture_u = @pictureable_u.picture
    @user = users(:divjot)
    
  end
  
  test "successful update where pictureable is scorebaord" do
    log_in_as(@user)
    picture = "random-pic.jpg"
    patch scoreboard_picture_path(@scoreboard, @picture_s), picture: {picture: picture}
    assert_equal "Picture updated successfully", flash[:success]
    # @picture_s.reload
    # assert_equal picture, @pictureable_s.picture
  end
  
  test "successful update where pictureable is a user" do
    log_in_as(@user)
    patch user_picture_path(@user, @picture_u), picture: {picture: "blank-prof.jpg"}
    assert_equal "Picture updated successfully", flash[:success]
  end
  
end
