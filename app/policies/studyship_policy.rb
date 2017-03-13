class StudyshipPolicy < ApplicationPolicy

  def index?
    record.student == user || record.teacher == user
  end

  def create?
    true
  end

  def destroy?
    record.student == user || record.teacher == user
  end
end
