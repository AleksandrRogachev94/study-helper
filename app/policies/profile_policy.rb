class ProfilePolicy < ApplicationPolicy

  def update?
    record.user == user
  end

  def show?
    record.user == user
  end
end
