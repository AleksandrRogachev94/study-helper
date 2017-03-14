class RequestPolicy < ApplicationPolicy

  def update?
    record.teacher == user
  end

  def destroy?
    record.teacher == user
  end

  class Scope < Scope
    def resolve
      scope.where(teacher: user)
    end
  end
end
