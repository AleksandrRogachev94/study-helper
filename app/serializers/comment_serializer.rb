class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :author, :can_update, :can_destroy

  def author
    {
      id: object.author.id,
      email: object.author.email,
      appearance: object.author.appearance,
      avatar_url: ActionController::Base.helpers.asset_path(object.author.profile.avatar.url(:thumb))
    }
  end

  def created_at
    object.created_at.to_f * 1000 # convert to milliseconds since 1970-01-01 00:00:00 UTC.
  end

  def can_update
    Pundit.policy(current_user, object).update?
  end

  def can_destroy
    Pundit.policy(current_user, object).destroy?
  end
end
