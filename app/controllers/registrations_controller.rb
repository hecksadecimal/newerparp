class RegistrationsController < Devise::RegistrationsController

  protected
    def update_resource(resource, params)
        if params[:current_password].blank?
            resource.update_without_password(params.except(:current_password))
        else
            resource.update_with_password(params)
        end
    end
end