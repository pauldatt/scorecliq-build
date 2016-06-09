require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  def setup 
    @pictureable = scoreboards(:scoreboard_a)
    @picture = @pictureable.build_picture(picture: "rails.png", pictureable_type: "scoreboard")
  end
  
  #if you run the if @picture.valid?, it won't be because the fixture_file_upload method does not work
  # in the model tests. Not sure why
  
  test "picture must be present" do 
    @picture.picture = nil
    assert_not @picture.valid?
  end
  
  test "pictureable type must be present" do
    @picture.pictureable_type = nil
    assert_not @picture.valid?
  end
  
  test "pictureable id must be present" do
    @picture.pictureable_id = nil
    assert_not @picture.valid?
  end
  
  test "picture must be <= 3mb" do
    if @picture.picture.size > 3.megabytes
      assert_not @picture.valid?
    end
  end
  
  #test for different types of pictures files that can be uploaded
  
end
