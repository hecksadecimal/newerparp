# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  # Configure additional authorization contexts here
  # (`user` is added by default).
  #
  #   authorize :account, optional: true
  #
  # Read more about authorization context: https://actionpolicy.evilmartians.io/#/authorization_context
  private

  # Define shared methods useful for most policies.
  # For example:
  #
  #  def owner?
  #    record.user_id == user.id
  #  end

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
