class ProfilePolicy < ApplicationPolicy

  def update?
    record.user == user
  end
end
