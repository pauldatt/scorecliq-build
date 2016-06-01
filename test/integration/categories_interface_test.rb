require 'test_helper'

class CategoriesInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
    @category = categories(:category_a)
    @scoreboard = scoreboards(:scoreboard_a)
    @user = users(:divjot)
    log_in_as(@user)
  end
  
  test "successfully creation of a category" do 
  get new_scoreboard_category_path(@scoreboard) 
    assert_difference("@scoreboard.categories.count", 1) do 
      post scoreboard_categories_path(@scoreboard), category: {name: "category"}
      assert_equal "created successfully", flash[:notice] 
    end
  end
  
  test "UNsuccessful creating of a category" do 
  get new_scoreboard_category_path(@scoreboard) 
    assert_no_difference("@scoreboard.categories.count") do 
      post scoreboard_categories_path(@scoreboard), category: {name: "  "}
      assert_equal "not created", flash[:notice] 
    end
  end
  
  test "successfully deleting a category" do 
    assert_difference("@scoreboard.categories.count", -1) do 
      delete scoreboard_category_path(@scoreboard, @category)
      assert_equal "deleted successfully", flash[:success] 
    end
  end
  
end
