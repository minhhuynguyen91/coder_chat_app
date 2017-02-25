class User < ApplicationRecord
    has_secure_password
    
    #validates :username, presence: true
    #validates :username, uniqueness: true
    
    validates :email, presence: true
    validates :email, uniqueness: true
    
    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
    has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

    def unread_messages
      received_messages.where(read_at: nil)
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
