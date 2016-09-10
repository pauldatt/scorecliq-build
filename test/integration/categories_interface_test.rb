require 'test_helper'

class CategoriesInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
    @category = categories(:category_a)
    @scoreboard = scoreboards(:scoreboard_a)
    @scoreboard_e = scoreboards(:scoreboard_e)
    @scoreboard_c = scoreboards(:scoreboard_c)
    @user = users(:divjot)
    @unsub_user = users(:shane)
    @sub_user = users(:sukh)
  end
  
  test "successfully creation of a category" do 
    log_in_as(@user)
    assert_difference("@scoreboard.categories.count", 1) do 
      post scoreboard_categories_path(@scoreboard), category: {name: "category"}
      assert_equal "Category has been created.", flash[:success] 
    end
  end
  
  test "UNsuccessful creating of a category" do 
    log_in_as(@user)
    assert_no_difference("@scoreboard.categories.count") do 
      post scoreboard_categories_path(@scoreboard), category: {name: "  "}
      assert_equal "Category could not be created successfully.", flash[:danger] 
    end
  end
  
  test "successfully deleting a category" do 
    log_in_as(@user)
    assert_difference("@scoreboard.categories.count", -1) do 
      delete scoreboard_category_path(@scoreboard, @category)
      assert_equal "Category was deleted successfully", flash[:success] 
    end
  end
  
  test "destroying associated documents when categories is destroyed" do 
    log_in_as(@user)
    # in the document.yml file, both documents belong to category_a
    # therefore, if the category is destroyed, there will be nothing in the database.
    # Document.count will change by 2
    assert_difference("Document.count", -2) do 
      @category.destroy
    end
  end
  
  test "unsubscribed user cannot create more than 5 categories" do 
    log_in_as(@unsub_user)
     assert_no_difference("@scoreboard_e.categories.count") do 
      post scoreboard_categories_path(@scoreboard_e), category: {name: "category"}
      assert_redirected_to scoreboard_categories_path(@scoreboard_e)
      assert_equal "Owner of league page must be subscribed in order to create more than 5 document categories", flash[:danger]
    end
  end
  
  
  test "subscribed user cannot create more than 10 categories" do 
    log_in_as(@sub_user)
     assert_no_difference("@scoreboard_c.categories.count") do 
      post scoreboard_categories_path(@scoreboard_c), category: {name: "category"}
      assert_redirected_to scoreboard_categories_path(@scoreboard_c)
      assert_equal "Only 10 categories can be created per league.", flash[:danger]
    end
  end
  
  
end

