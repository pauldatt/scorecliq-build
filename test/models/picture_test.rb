require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  
  def setup 
    @pictureable = scoreboards(:scoreboard_a)
    @picture = @pictureable.build_picture(picture: "picture")
  end
  
  test "pictureable valid" do 
    assert @picture.valid?
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
