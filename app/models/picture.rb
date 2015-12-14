class Picture < ActiveRecord::Base
     belongs_to :pictureable, polymorphic: true
     mount_uploader :picture, PictureUploader 
     
     validate :picture_size
     
end

private

def picture_size 
 if picture.size > 5.megabytes
   errors.add(:picture, "should be less than 5MB")
 end
end
