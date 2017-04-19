class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  has_attached_file :doc1
                    # storage: :s3, s3_credentials: aws_s3_credentials
  has_attached_file :doc2
                    # storage: :s3, s3_credentials: aws_s3_credentials

  validates_attachment_content_type :doc1, :doc2, :content_type => ["application/pdf","application/vnd.ms-excel",
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword",
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
             "text/plain"]
  validates_with AttachmentSizeValidator, attributes: [:doc1, :doc2], less_than: 2.megabytes

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
