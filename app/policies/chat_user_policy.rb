class ChatUserPolicy < ApplicationPolicy
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
  
    def update?
      generate_context(user)
      record.user_id == user.id
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
  