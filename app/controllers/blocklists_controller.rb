class BlocklistsController < ApplicationController
  def index

  end

  def create
    @block = current_user.blocklists.build(:block_id => params[:block_id])
    if @block.save
      flash[:success] = "Blocked user"
    else
      flash[:error] = ["Unable to block"]
    end
    redirect_to user_path(current_user)
  end

  def destroy
    @block = current_user.blocklists.find_by(:block_id => params[:block_id])
    @block.destroy
    flash[:success] = "Unblocked user"
    redirect_to user_path(current_user)

  end

end
