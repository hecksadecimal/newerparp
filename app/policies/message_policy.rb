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
      generate_context(user)
      (user.admin? && user.permissions.where(permission: "groups").any?)
    end

    def create?
      generate_context(user)
      chat_user = ChatUser.find_by(user_id: user.id, chat_id: record.chat.id)
      if (user.admin? && user.permissions.where(permission: "groups").any?)
        return true
      end

      if !user.admin? || user.beta_code.nil?
        return false
      end

      if user.id == record.user_id && allowed_to?(:show?, record.chat) && !chat_user.silent?
        puts "CONDITION PASSED!!!!"
        return true
      end
      
      return false
    end
  
    def show?
      generate_context(user)
      (user.admin? && user.permissions.where(permission: "groups").any?) || ["listed", "unlisted", "pinned"].include?(record.chat.group_chat.publicity) || record.account == user
    end
  
    def update?
      generate_context(user)
      if !user.admin? || !user.beta_code.nil?
        return false
      end
      
      record.account == user || (user.admin? && user.permissions.where(permission: "groups").any?)
    end
    
    def destroy?
      generate_context(user)
      user.admin? && user.permissions.where(permission: "groups").any?
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
  