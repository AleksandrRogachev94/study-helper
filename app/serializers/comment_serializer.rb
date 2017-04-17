class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :author

  def author
    {
      id: object.author.id,
      email: object.author.email,
      appearance: object.author.appearance
    }
  end

  def created_at
    object.created_at.to_s
  end
end
