require 'test_helper'

class FavouriteTest < ActiveSupport::TestCase
  
  def setup 
    @favourite = Favourite.new(user_id: 1, scoreboard_id: 3)
  end
  
  test "should be valid" do
    assert @favourite.valid?
  end
  
  test "user_id must be present" do
    @favourite.user_id = nil
    assert_not @favourite.valid?
  end
  
  test "scoreboard_id must be present" do
    @favourite.scoreboard_id = nil
    assert_not @favourite.valid?
  end
  
end
