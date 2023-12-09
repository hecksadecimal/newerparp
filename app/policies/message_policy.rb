class MessagePolicy < ApplicationPolicy
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
  
    def index?
      (user.admin? && user.permissions.where(permission: "groups").any?)
    end

    def create?
      UNLEASH.is_enabled? "beta", @unleash_context
    end
  
    def show?
      (user.admin? && user.permissions.where(permission: "groups").any?) || ["listed", "unlisted", "pinned"].include?(record.chat.group_chat.publicity) || record.account == user
    end
  
    def update?
      UNLEASH.is_enabled? "beta", @unleash_context && record.account == user || (user.admin? && user.permissions.where(permission: "groups").any?)
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
  