require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home | Scorecliq"
  end

  test "should get Guide" do
    get :guide
    assert_response :success
    assert_select "title", "Guide | Scorecliq"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | Scorecliq"
  end
  
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | Scorecliq"
  end
end

