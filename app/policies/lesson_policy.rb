class LessonPolicy < ApplicationPolicy

  def show?
    record.user == user || user.teachers.include?(record.user)
  end

  def index?
    show?
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
