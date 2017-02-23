class UsersController < ApplicationController
  before_action :require_signin, only: [:show, :index]

  def show
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User is successfully created"
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages
      render 'new'
    end
  end

  def index
    @users = User.where.not(:id => current_user.id)
  end

  def friends
    
  end

  def add_friend
    user = current_user
    user.friend_list_ids.push(params[:id].to_i)
    user.save
    redirect_to users_path
  end

  def remove_friend
    user = current_user
    user.friend_list_ids = user.friend_list_ids - [params[:id].to_i]
    user.save
    redirect_to users_path
  end

  
  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
