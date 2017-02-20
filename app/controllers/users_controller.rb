class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "User is successfully created"
    else
      flash.now[:error] = @user.erros.full_messages
    end
    
  end
  
  private
    def users_params
      params.require(:user).permit(:username, :email, :password_digest)
    end
end
