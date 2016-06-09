require 'test_helper'

class DocumentInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @category = categories(:category_a)
    @document = documents(:document_a)
    @user = users(:divjot)
    log_in_as(@user)
  end
  
  test "successfully posting a document" do 
    doc = fixture_file_upload('test/fixtures/rails.doc', 'file/doc')
    assert_difference("@category.documents.count", 1) do 
      post scoreboard_category_documents_path(@scoreboard, @category), document: {file_name: "randomname",
                                                                                  file: doc }
      
    end
  end
  
  test "UNsuccessful posting of a document" do 
    assert_no_difference("@category.documents.count") do 
      post scoreboard_category_documents_path(@scoreboard, @category), document: {file_name: " ",
                                                                                  file: " " }
    end
  end
  
  
  
  
end
