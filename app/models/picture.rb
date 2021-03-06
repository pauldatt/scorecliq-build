class Picture < ActiveRecord::Base
     belongs_to :pictureable, polymorphic: true
     mount_uploader :picture, PictureUploader 
     
     validates :picture, presence: true
     validates :pictureable_id, presence: true
     validates :pictureable_type, presence: true
     validate  :picture_size
     
end

private

def picture_size 
 if picture.size > 3.megabyte
   errors.add(:picture, "should be less than 3 MB")
 end
end
