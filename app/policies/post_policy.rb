class PostPolicy < ApplicationPolicy
  def show?
    true
  end

  def delete?
    user.id == record.user_id
  end

  def update?
    user.id == record.user_id
  end
end