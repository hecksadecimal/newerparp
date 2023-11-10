class ChatPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  # def index?
  #   true
  # end
  #
  # def update?
  #   # here we can access our context and record
  #   user.admin? || (user.id == record.user_id)
  # end

  def show?
    (user.admin? && user.permissions.where(permission: "groups").any?) || ["listed", "unlisted", "pinned"].include?(record.group_chat.publicity) || record.accounts.include?(user)
  end

  def update?
    record.group_chat? && record.group_chat.creator_id == user.id || (user.admin? && user.permissions.where(permission: "groups").any?)
  end
  
  def destroy?
    user.admin? && user.permissions.where(permission: "groups").any?
  end
  
  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
