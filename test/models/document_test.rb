require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup 
    @category = categories(:category_a)
    @document = @category.documents.build(file_name: "abc", file: "abc.doc")
  end
  
  test "document valid" do 
    assert @document.valid?
  end
  
  
end
