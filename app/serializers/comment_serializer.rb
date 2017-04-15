class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at
  belongs_to :author, class_name: "User", foreign_key: "user_id"
end
