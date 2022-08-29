class CommentPolicy < ApplicationPolicy
  def show?
    true
  end

  def delete?
    user.id == record.user_id || user.id == record.post.user_id
  end

  def update?
    user.id == record.user_id
  end
end