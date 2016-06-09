require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  
  def setup 
    @category = categories(:category_a)
    @document = @category.documents.build(file: "abc", file_name: "abc")
  end
  
  #the test @document won't pass but everything else from the model tests will pass
  
  test "document file should be present" do 
    @document.file = " "
    assert_not @document.valid?
  end
  
  test "file_name must be present" do 
    @document.file_name = " "
    assert_not @document.valid?
  end
  
  test "file must be present" do 
    @document.file = " "
    assert_not @document.valid?
  end
  
  test "file size must be <= 3mb" do 
    if @document.file.size > 3.megabytes
      assert_not @document.valid?
    end
  end
  
end
