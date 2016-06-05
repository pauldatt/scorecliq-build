require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @category = @scoreboard.categories.build(name: "abcdef")
  end
  
  
  test "destroying associated documents when categories is destroyed" do 
    example_file = fixture_file_upload('/files/gorilla.doc')
    @category.save
    @category.documents.create!(file_name: "abc", file: example_file )
    assert_difference("Document.count", -1) do 
      @category.destroy
    end
  end
  
end
