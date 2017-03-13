class LessonPolicy < ApplicationPolicy

  def show?
    record.user == user
  end

  # Record is a user from params
  def index?
    record.user == user
  end

  # Record is a user from params
  def new?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
