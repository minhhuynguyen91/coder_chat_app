class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :subject, presence: true
  validates :content, presence: true

  has_attached_file :image, styles: { medium: "800x600>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  
end
