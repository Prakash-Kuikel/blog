class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def delete?
    user.id == record.id
  end

  def update?
    user.id == record.id
  end
end