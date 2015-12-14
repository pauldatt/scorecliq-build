class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], approved: "false")
    if @friendship.save
      flash[:success] = "Friend Request Sent...."
      redirect_to :back
    else
      flash[:danger] = "Unable to send request!"
      redirect_to :back
    end
  end
  
  def update
    @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
    @friendship.update(approved: "true")
    if @friendship.save
      redirect_to :back
      flash[:success] = "successfully confirmed friend"
    else
      flash[:danger] = "sorry!, couldn't confirm friend."
    end
  end

  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy
    flash[:success] = "Removed Friend"
    redirect_to :back
  end
end
