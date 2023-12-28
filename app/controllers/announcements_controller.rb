class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: %i[ show ]

  # GET /announcements or /announcements.json
  def index
    @pagy, @announcements = pagy(Announcement.all, items: 5)
  end

  # GET /announcements/1 or /announcements/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def announcement_params
      params.fetch(:announcement, {})
    end
end
