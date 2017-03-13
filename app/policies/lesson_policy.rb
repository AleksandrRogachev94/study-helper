class LessonPolicy < ApplicationPolicy

  def show?
    #record.user == user
    true
  end

  def index?
    #record.user == user
    true
  end

  def new?
    record.user == user
  end

  def create?
    true
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
