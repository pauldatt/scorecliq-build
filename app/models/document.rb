class Document < ActiveRecord::Base

  belongs_to :category
  mount_uploader :file, FileUploader
  
  validates :file_name, presence: true, length: {maximum: 30}
  validates :file, presence: true
  validate :file_size
  
  private 
  
  def file_size
   if file.size > 3.megabyte
      errors.add(:file, "should be less than 3 mb")
   end
  end
  
  
end
