class LessonSerializer < ActiveModel::Serializer
  attributes :id, :description, :content, :links, :created_at, :author
  has_many :comments

  def author
    {
      email: object.author.email,
      appearance: object.author.appearance
    }
  end

  def created_at
    object.created_at.to_s
  end
end
