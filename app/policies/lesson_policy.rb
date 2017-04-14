class LessonPolicy < ApplicationPolicy

  def show?
    record.author == user || user.teachers.include?(record.author)
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
    record.author == user
  end
end
