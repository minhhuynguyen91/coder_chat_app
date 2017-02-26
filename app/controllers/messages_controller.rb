class MessagesController < ApplicationController
  before_action :require_signin
  before_action :read_message, :only => [:show]

  def index
  end

  def new
    @message = Message.new
    @friends = current_user.friendships
  end

  def new_group
    @users = User.where.not(:id => current_user.id)
  end

  def create_group
    # Remove empty array element
    @send_lists = params[:email].split
    @send_lists = Message.filter_email_group(@send_lists, current_user.id)
    
    @send_lists.each do |send_email|
      @recipient = User.find_by(:email => send_email)
      @message = Message.new(
        :subject => params[:subject],
        :content => params[:content],
        :sender_id => current_user.id,
        :image => params[:image],
        :recipient_id => @recipient.nil? ? 999 : @recipient.id
      )

      @message.save
    end
    redirect_to incoming_messages_path
  end

  def create
    @message = Message.new(message_params)
    @friends = current_user.friendships
    if @message.save
      flash[:success] = "Your message has been created"
      redirect_to incoming_messages_path
    else
      flash.now[:error] = @message.errors.full_messages
      render 'new'
    end

  end

  def show
    @message = Message.find(params[:id])
    @message.read_at = Time.now
    @message.save  
    
  end
  
  def incoming
    @inbox_messages = current_user.received_messages.order(:created_at => :desc)
  end
  
  def sent
    @sent_messages  = current_user.sent_messages.order(:created_at => :desc)
  end
  
  private
    def message_params
      params.require(:message).permit(:subject, :content, :recipient_id, :sender_id, :image)
    end
end
