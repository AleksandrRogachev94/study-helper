class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :content, :links, :created_at, :author, :can_update, :can_destroy, :next_id, :prev_id
  has_many :comments
  belongs_to :category

  def author
    {
      id: object.author.id,
      email: object.author.email,
      appearance: object.author.appearance,
      avatar_url: ActionController::Base.helpers.asset_path(object.author.profile.avatar.url(:thumb))
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

  def next_id
    lessons = object.author.lessons

    index = lessons.find_index { |lesson| lesson == object } + 1
    index < lessons.size ? lessons[index].id : nil
  end

  def prev_id
    lessons = object.author.lessons

    index = lessons.find_index { |lesson| lesson == object } - 1
    index >= 0 ? lessons[index].id : nil
  end
end
