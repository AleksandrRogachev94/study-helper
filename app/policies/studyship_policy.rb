class StudyshipPolicy < ApplicationPolicy

  def teachers?
    record.student == user
  end

  def students?
    record.teacher == user
  end

  def create?
    true
  end

  def destroy?
    record.student == user || record.teacher == user
  end
end
