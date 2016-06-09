require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @category = @scoreboard.categories.build(name: "abcdef")
  end
  
  test "category should be valid" do 
    @category.name = " "
    assert_not @category.valid?
  end
  
  test "category name must be present" do 
    @category.name = " "
    assert_not @category.valid?
  end
  
end
