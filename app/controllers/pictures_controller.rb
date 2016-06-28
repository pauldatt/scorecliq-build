class PicturesController < ApplicationController
    
before_filter :load_pictureable

before_action :logged_in_user

def create
    @picture = @pictureable.build_picture(picture_params)
    if @picture.save
        flash[:success] = "Uploaded Successfully"
        redirect_to @pictureable
    else
        redirect_to @pictureable
        flash[:danger] = "An error occured, please try again!"
    end
end

def update
    @picture = @pictureable.picture
    if @picture.update_attributes(picture_params)
        redirect_to @pictureable
        flash[:success] = "Picture updated successfully"
     else
        redirect_to @pictureable
        flash[:danger] = "An error occured, please try again!"
    end
end


def destroy
    @pictureable.picture.delete
    redirect_to @pictureable
    flash[:success] = "Picture removed successfully"
end
    

private

def picture_params
    params.require(:picture).permit(:picture)
end

def load_pictureable
    resource, id = request.path.split('/')[1,2]
    @pictureable = resource.singularize.classify.constantize.find(id)
end
        
end