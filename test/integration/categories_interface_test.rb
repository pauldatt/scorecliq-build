require 'test_helper'

class CategoriesInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
    @category = categories(:category_a)
    @scoreboard = scoreboards(:scoreboard_a)
    @user = users(:divjot)
    log_in_as(@user)
  end
  
  test "successfully creation of a category" do 
    assert_difference("@scoreboard.categories.count", 1) do 
      post scoreboard_categories_path(@scoreboard), category: {name: "category"}
      assert_equal "Category has been created.", flash[:success] 
    end
  end
  
  test "UNsuccessful creating of a category" do 
    assert_no_difference("@scoreboard.categories.count") do 
      post scoreboard_categories_path(@scoreboard), category: {name: "  "}
      assert_equal "Category could not be created successfully.", flash[:danger] 
    end
  end
  
  test "successfully deleting a category" do 
    assert_difference("@scoreboard.categories.count", -1) do 
      delete scoreboard_category_path(@scoreboard, @category)
      assert_equal "Category was deleted successfully", flash[:success] 
    end
  end
  
end
