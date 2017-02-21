class MessagesController < ApplicationController
  def index
    
  end

  def new
  end

  def create
  end

  def show
  end
  
  def incoming
    @inbox_messages = current_user.received_messages.order(:created_at => :desc)
  end
  
  def sent
    @sent_messages  = current_user.sent_messages.order(:created_at => :desc)
  end
  
  private
    def message_params
      params.require(:message).permit(:subject, :content, :sender_id, :recipient_id)
    end
end
