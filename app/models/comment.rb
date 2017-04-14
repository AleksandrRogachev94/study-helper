class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :lesson

  validates :content, presence: true
end
