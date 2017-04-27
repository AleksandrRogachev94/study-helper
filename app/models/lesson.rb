class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  has_attached_file :doc1
  has_attached_file :doc2
  has_attached_file :doc3

  validates_attachment_content_type :doc1, :doc2, :doc3, :content_type => ["application/pdf","application/vnd.ms-excel",
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/vnd.openxmlformats-officedocument.presentationml.presentation",
             "application/msword",
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
             "text/plain"]
  validates_with AttachmentSizeValidator, attributes: [:doc1, :doc2, :doc3], less_than: 2.megabytes

  process_in_background :doc1
  process_in_background :doc2
  process_in_background :doc3

  has_many :comments, dependent: :destroy

  before_save :make_capitalized

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 20 }

  def category_attributes=(attrs)
    if attrs[:title].present?
      category = Category.where("lower(title) = ?", attrs[:title]).first_or_initialize(title: attrs[:title])
      self.category = category
    end
  end

  def make_capitalized
    self.title.capitalize!
  end
end
