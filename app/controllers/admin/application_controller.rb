# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin
    before_action :set_last_seen

    def authenticate_admin
      authenticate_account!
    end

    def authorize_resource(resource)
      raise "Erg!" unless current_account.admin?
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    private
      def set_last_seen
        if current_account
          current_account.last_seen_at = DateTime.now
          current_account.save
        end
      end
  end
end
