require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "1password", password_confirmation: "1password")
    @scoreboard = scoreboards(:scoreboard_a)
    @team = teams(:team_a)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should have a minimum length of 8" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "passwords should have atleast one letter" do 
    @user.password = @user.password_confirmation = "12345678"
    assert_not @user.valid?
  end
  
  test "password should have atleast one number" do 
    @user.password = @user.password_confirmation = "abcdefgh"
    assert_not @user.valid?
  end
  
  test "correct password format and test must pass" do 
    @user.password = @user.password_confirmation = "12abcdeg"
    assert @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated scoreboards should be destroyed" do
    @user.save
    @user.scoreboards.create!(name_of_scoreboard: "Scoreboard A", name_of_organization: 
                  "Organization A", name_of_activity: "Activity A" )
    assert_difference "Scoreboard.count", -1 do
      @user.destroy
    end
  end
  
   test "associated comments should be destroyed if user is destroyed" do 
      @user.save
      @user.comments.create!(body: "abc", reply: "def")
      assert_difference"Comment.count", -1 do 
        @user.destroy
      end
    end
    
    test "associated favourites should be destroyed if user is destroyed" do 
      @user.save
      @user.favourites.create!(scoreboard_id: 1)
      assert_difference"Favourite.count", -1 do 
        @user.destroy
      end
    end
    
    test "associated requests must be destroyed if user is destroyed" do 
      @user.save
      @user.requests.create!(scoreboard_id: @scoreboard.id)
      assert_difference"Request.count", -1 do 
        @user.destroy
      end
    end
    
    test "associated managers must be destroyed if user is destroyed" do 
      @user.save
      @user.managers.create!(scoreboard_id: @scoreboard.id)
      assert_difference"Manager.count", -1 do 
        @user.destroy
      end
    end
    
     test "associated picture must be destroyed if user is destroyed" do 
      @user.save
      @user.build_picture(picture: "abc.jpg", pictureable_type: "user")
      assert_difference"Picture.count", -1 do 
        @user.destroy
      end
     end
    
    test "associated team members must be destroyed if user is destroyed" do 
    @user.save
      @user.team_members.create!(team_id: @team.id)
      assert_difference"TeamMember.count", -1 do 
        @user.destroy
      end
    end
    
    #team_member test gives me a bug error as before
    
  
end 
