class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method  :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def require_signin
    unless signed_in?
      flash[:error] = ["You must sign in"]
      redirect_to signin_path
    end
  end

  def read_message
     unless Message.find_by_id(params[:id]).read_at.nil?
      flash[:error] = ["Your message is read"]
      redirect_to incoming_messages_path
     end
  end

end
