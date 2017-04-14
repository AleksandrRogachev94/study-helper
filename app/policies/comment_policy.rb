class CommentPolicy < ApplicationPolicy

  def show?
    record.lesson.author == user || user.teachers.include?(record.lesson.author)
  end

  def index?
    show?
  end

  def create?
    true
  end

  def update?
    record.author == user
  end

  def destroy?
    record.author == user || record.lesson.author == user
  end
end
