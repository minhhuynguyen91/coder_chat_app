class MessagesController < ApplicationController
  before_action :require_signin
  before_action :read_message, :only => [:show]

  def index
  end

  def new
    @message = Message.new
    @friends = current_user.friend_list_ids
  end

  def create
    @message = Message.new(message_params)
    @friends = current_user.friend_list_ids
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
