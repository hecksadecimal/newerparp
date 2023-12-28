class ApplicationController < ActionController::Base
    include Pagy::Backend
    include ApplicationHelper

    before_action :set_unleash_context
    before_action :set_sentry_context
    before_action :set_last_seen
    before_action :configure_permitted_parameters, if: :devise_controller?


    authorize :user, through: :current_account

    def pagy_calendar_period(collection)
        minmax = collection.pluck('MIN(created_at)', 'MAX(created_at)').first
        minmax.map { |time| Time.parse(time).in_time_zone }
    end

    def pagy_calendar_filter(collection, from, to)
        collection.where(created_at: from...to)  # 3-dots range excluding the end value
    end

    private
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
            devise_parameter_sanitizer.permit(:account_update, keys: [:email])

        end

        def set_last_seen
            if current_account
                current_account.last_seen_at = DateTime.now
                current_account.save
            end
        end

        def set_unleash_context
            @unleash_context = Unleash::Context.new(
                session_id: session.id,
                remote_address: request.remote_ip,
                user_id: current_account ? current_account.id : nil,
                betakey: (current_account && current_account.beta_code.present?) ? current_account.beta_code.code : "",
                admin: (current_account && current_account.admin?) ? true : false,
                properties: { 
                    betakey: (current_account && current_account.beta_code.present?) ? current_account.beta_code.code : "",
                    admin: (current_account && current_account.admin?) ? true : false
                }
            )
        end

        def set_sentry_context
            if current_account
                Sentry.set_user(id: current_account.id, username: current_account.username, email: current_account.email, ip: request.remote_ip)
            else
                Sentry.set_user(ip: request.remote_ip)
            end
        end
end
