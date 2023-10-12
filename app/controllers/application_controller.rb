class ApplicationController < ActionController::Base
    include Pagy::Backend
    include ApplicationHelper

    def pagy_calendar_period(collection)
        minmax = collection.pluck('MIN(created_at)', 'MAX(created_at)').first
        minmax.map { |time| Time.parse(time).in_time_zone }
    end

    def pagy_calendar_filter(collection, from, to)
        collection.where(created_at: from...to)  # 3-dots range excluding the end value
    end
end
