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

  def create?
    generate_context(user)
    user.admin? || !user.beta_code.nil?
  end

  def show?
    generate_context(user)
    (user.admin? && user.permissions.where(permission: "groups").any?) || (record.group_chat.present? && ["listed", "unlisted", "pinned"].include?(record.group_chat.publicity)) || record.accounts.include?(user)
  end

  def update?
    generate_context(user)
    record.group_chat? && record.group_chat.creator_id == user.id || (record.accounts.include?(user) && record.chat_users.find_by(user_id: user.id).group == "mod3" ) || (user.admin? && user.permissions.where(permission: "groups").any?)
  end
  
  def destroy?
    generate_context(user)
    user.admin? && user.permissions.where(permission: "groups").any?
  end

  def join?
    generate_context(user)
    (user.admin? && user.permissions.where(permission: "groups").any?) || (record.group_chat.present? && ["listed", "unlisted", "pinned"].include?(record.group_chat.publicity))
  end
  
  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end

  def generate_context(user)
    @unleash_context = Unleash::Context.new(
      user_id: user ? user.id : nil,
      betakey: (user && user.beta_code.present?) ? user.beta_code.code : "",
      admin: (user && user.admin?) ? true : false,
      properties: { 
          betakey: (user && user.beta_code.present?) ? user.beta_code.code : "",
          admin: (user && user.admin?) ? true : false
      }
    )
  end
end
