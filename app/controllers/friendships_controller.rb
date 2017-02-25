class FriendshipsController < ApplicationController
  def index
    @friendship_requests = Friendship.where(:friend_id => current_user.id)
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:success] = "Added friend."
    else
      flash[:error] = ["Unable to add friend."]
    end
    redirect_to users_path
  end

  def destroy

    @friendship = current_user.friendships.find_by(:friend_id => params[:friend_id])
    @friendship.destroy
    flash[:success] = "Removed friendship."
    redirect_to users_path

  end

end
