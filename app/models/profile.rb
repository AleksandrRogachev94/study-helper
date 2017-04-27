class Profile < ApplicationRecord
  belongs_to :user
  has_attached_file :avatar, default_url: ':style/default_avatar.jpg', styles: { thumb: "100x100>" }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes

  process_in_background :avatar

  before_save :capitalize_name

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def full_name=(full_name)
    self.first_name, self.last_name = full_name.split(" ")
  end

  def capitalize_name
    self.first_name.capitalize!
    self.last_name.capitalize!
  end

  def avatar_from_url=(url)
    self.avatar = URI.parse(url)
  end
end
