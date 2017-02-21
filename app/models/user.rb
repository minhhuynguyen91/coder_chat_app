class User < ApplicationRecord
    has_secure_password
    
    validates :username, presence: true
    validates :username, uniqueness: true
    
    validates :email, presence: true
    validates :email, uniqueness: true
    
    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
    has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

    def unread_messages
      received_messages.where(read_at: nil)
    end
end
