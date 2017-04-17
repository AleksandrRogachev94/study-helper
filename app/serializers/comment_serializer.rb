class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :author, :can_update, :can_destroy

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

  def can_update
    Pundit.policy(current_user, object).update?
  end

  def can_destroy
    Pundit.policy(current_user, object).destroy?
  end
end
