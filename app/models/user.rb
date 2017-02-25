class User < ApplicationRecord
    has_secure_password
    
    #validates :username, presence: true
    #validates :username, uniqueness: true
    
    validates :email, presence: true
    validates :email, uniqueness: true
    
    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
    has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

    has_many :friendships
    has_many :friends, :through => :friendships

    has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
    has_many :inverse_friends, :through => :inverse_friendships, :source => :user

    def unread_messages
      received_messages.where(read_at: nil)
    end

    def is_friend(current_user_id)
      #!Friendship.where(:user_id => current_user_id, :friend_id => self.id).empty?
      #or !Friendship.where(:user_id => self.id, :friend_id => current_user_id).empty?
      user = User.find_by_id(current_user_id)
      return !user.friendships.find_by(:friend_id => self.id).nil?
    end

    def self.from_omniauth(auth)
      # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
      # and figure out how to get email for this user.
      # Note that Facebook sometimes does not return email,
      # in that case you can use facebook-id@facebook.com as a workaround
      email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
      #Rails.logger.debug "Auth info: #{auth[:info].inspect}"
      #Rails.logger.debug "Auth info: #{auth[:extra][:raw_info].inspect}"


      name  = auth[:info][:name] || "Dump username"

      user = where(email: email).first_or_initialize
      user.username = name
      user.password = SecureRandom.base64

      #
      # Set other properties on user here. Just generate a random password. User does not have to use it.
      # You may want to call user.save! to figure out why user can't save
      #
      # Finally, return user
      user.save && user
    end
end
