require 'test_helper'

class PicturePostTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
  end
  
  test 'successfully post of a picture, pictureable as scoreboard' do
      post scoreboard_pictures_path(@scoreboard), picture: {picture: "blank-prof.jpg"}
      assert_equal "Uploaded Successfully", flash[:success]
  end
  
  test 'successful post of a picture, pictureable as user' do
      post user_pictures_path(@user), picture: {picture: "blank-prof.jpg"}
      assert_equal "Uploaded Successfully", flash[:success]
  end
  
  
  
end
  

