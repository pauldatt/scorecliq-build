class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy, :home] # Each individual must sign up before they can see any profiles
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def home
  end
  
  def index
    if params[:name]
      @users = User.search(params[:name]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end
  
  def show
    @user = User.find(params[:id])
    @pictureable = @user
    @picture =  @pictureable.picture || @pictureable.build_picture
  end
  
  def new
    @user = User.new #new action displays the form in the new action for creating new users.
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check you email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Updated Successfully"
      redirect_to @user
      # Handle a successful update
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted successfully"
    redirect_to users_url
  end
  

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  
  # This method confirms that the correct user 
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) 
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
     
end

