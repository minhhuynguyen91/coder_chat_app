class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :subject, presence: true
  validates :content, presence: true

  has_attached_file :image, styles: { medium: "800x600>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def self.filter_email_group(email_lists, current_user_id)
    current_user_check = User.find_by(:id => current_user_id)
    # Remove empty element
    email_lists = email_lists.reject(&:empty?)
    # Remove the current user email
    email_lists = email_lists.reject { |x| x == current_user_check.email }
    return email_lists
  end
  
end
