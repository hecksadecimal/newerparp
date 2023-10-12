class GroupChat < ApplicationRecord
    belongs_to :chat, foreign_key: "id", dependent: :destroy
    enum publicity: { 
        listed: "listed", 
        unlisted: "unlisted", 
        pinned: "pinned", 
        admin_only: "admin_only", 
        private_chat: "private"
    }
end
