require 'test_helper'

class PictureUpdateTest < ActionDispatch::IntegrationTest
  
  def setup
    @pictureable_s = scoreboards(:scoreboard_a) #picture_a is associated with scoreboard_a
    @picture_s = @pictureable_s.picture #this is the picture associated with the pictureable (scoreboard_a)
    @scoreboard = scoreboards(:scoreboard_a) #pictureable is scoreboard_a
    
    @pictureable_u = users(:divjot)
    @picture_u = @pictureable_u.picture
    @user = users(:divjot)
    
    @user_lana = users(:lana)
    
  end
  
  test "successful update where pictureable is scorebaord" do
    log_in_as(@user)
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    patch scoreboard_picture_path(@scoreboard, @picture_s), picture: {picture: picture}
    assert_equal "Picture updated successfully", flash[:success]
    # @picture_s.reload
    # assert_equal picture, @pictureable_s.picture
  end
  
  test "successful update where pictureable is a user" do
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    log_in_as(@user)
    patch user_picture_path(@user, @picture_u), picture: {picture: picture}
    assert_equal "Picture updated successfully", flash[:success]
  end
  
  # cannot use the variable @user because @user owns the scoreboard_a, therefore, if I destroy 
  # the user, it also destroys the scoreboard and the picture associated with it in the yaml file. Therefore, I used
  # a compltetely different user(lana)
  test "associated picture must be destroyed if user is destroyed" do 
    assert_difference"Picture.count", -1 do 
      @user_lana.destroy
    end
  end
  
  
  test "associated picture must be destroyed if scorebaord is destroyed" do 
    assert_difference"Picture.count", -1 do 
      @scoreboard.destroy
    end
  end
  
end
