require 'test_helper'

class PicturePostTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
  end
  
  test 'successfully post of a picture, pictureable as scoreboard' do
      log_in_as(@user)
      picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
      post scoreboard_pictures_path(@scoreboard), picture: {picture: picture}
      assert_equal "Uploaded Successfully", flash[:success]
  end
  
  test 'successful post of a picture, pictureable as user' do
      log_in_as(@user)
      picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
      post user_pictures_path(@user), picture: {picture: picture}
      assert_equal "Uploaded Successfully", flash[:success]
  end
  
  
  
end
  

