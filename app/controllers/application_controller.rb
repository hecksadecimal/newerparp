class ApplicationController < ActionController::Base
    include Pagy::Backend
    include ApplicationHelper

    before_action :set_unleash_context

    authorize :user, through: :current_account

    def pagy_calendar_period(collection)
        minmax = collection.pluck('MIN(created_at)', 'MAX(created_at)').first
        minmax.map { |time| Time.parse(time).in_time_zone }
    end

    def pagy_calendar_filter(collection, from, to)
        collection.where(created_at: from...to)  # 3-dots range excluding the end value
    end

    private
        def set_unleash_context
            @unleash_context = Unleash::Context.new(
                session_id: session.id,
                remote_address: request.remote_ip,
                user_id: current_account ? current_account.id : nil,
                betakey: (current_account && current_account.beta_code.present?) ? current_account.beta_code.code : "",
                properties: { betakey: (current_account && current_account.beta_code.present?) ? current_account.beta_code.code : "" }
            )
        end
end
