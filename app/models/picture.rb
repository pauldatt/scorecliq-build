class Picture < ActiveRecord::Base
     belongs_to :pictureable, polymorphic: true
     mount_uploader :picture, PictureUploader 
     
     validate :picture_size
     
end

private

def picture_size 
 if picture.size > 3.megabytes
   errors.add(:picture, "should be less than 3MB")
 end
end
