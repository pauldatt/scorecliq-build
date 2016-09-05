require 'test_helper'

class DocumentInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @scoreboard_c = scoreboards(:scoreboard_c)
    @category = categories(:category_a)
    @category_sukh = categories(:category_sukh)
    @document = documents(:document_a)
    @user = users(:divjot)
    @sub_user = users(:sukh)
  end
  
  test "successfully posting a document" do 
    log_in_as(@user)
    doc = fixture_file_upload('test/fixtures/rails.doc', 'file/doc')
    assert_difference("@category.documents.count", 1) do 
      post scoreboard_category_documents_path(@scoreboard, @category), document: {file_name: "randomname",
                                                                                  file: doc }
      assert_equal "Document uploaded successfully.", flash[:success]
    end
  end
  
  test "unsuccessful posting of a document with a BLANK FILE NAME" do 
    log_in_as(@user)
    assert_no_difference("@category.documents.count") do 
      post scoreboard_category_documents_path(@scoreboard, @category), document: {file_name: " ",
                                                                                  file: " " }
      assert_equal "Please try again. File name can't be blank.", flash[:danger]
    end
  end
  
   test "unsuccessful posting of a document with a BLANK DOCUMENT" do 
     log_in_as(@user)
    assert_no_difference("@category.documents.count") do 
      post scoreboard_category_documents_path(@scoreboard, @category), document: {file_name: "filename",
                                                                                  file: " " }
      assert_equal "Please try again. You must select a document for upload.", flash[:danger]
    end
  end
  
  test "unsuccessful posting of a document with a WRONG DOC TYPE" do 
    log_in_as(@user)
    wrong_doc = fixture_file_upload('test/fixtures/rails.jpg', 'file/doc')
    assert_no_difference("@category.documents.count") do 
      post scoreboard_category_documents_path(@scoreboard, @category), document: {file_name: "filename",
                                                                                  file: wrong_doc }
      assert_equal "Failed to Upload. Please check accepted file formats and try again.", flash[:danger]
    end
  end
  
  test "cannot upload more than 25 documents per category" do 
    log_in_as(@sub_user)
     doc = fixture_file_upload('test/fixtures/rails.doc', 'file/doc')
    assert_no_difference("@category_sukh.documents.count") do 
      post scoreboard_category_documents_path(@scoreboard_c, @category_sukh), document: {file_name: "randomname",
                                                                                  file: doc }
      assert_equal "Only 25 documents can be uploaded per category.", flash[:danger]
    end
  end
  
  
  
end
