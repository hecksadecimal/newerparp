class Announcement < ApplicationRecord
    default_scope { order(created_at: :desc) }
    belongs_to :account
    has_rich_text :content
end
