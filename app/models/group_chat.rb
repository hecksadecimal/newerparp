class GroupChat < ApplicationRecord
    belongs_to :chat, foreign_key: "id", dependent: :destroy
    enum publicity: { 
        listed: "listed", 
        unlisted: "unlisted", 
        pinned: "pinned", 
        admin_only: "admin_only", 
        private_chat: "private"
    }

    enum level: {
        sfw: "sfw",
        nsfw: "nsfw",
        nsfw_extreme: "nsfw-extreme",
        nsfw_sexual: "nsfws",
        nsfw_violent: "nsfwv"
    }

    enum style: {
        script: "script",
        paragraph: "paragraph",
        either: "either"
    }

    def self.publicities_for_account(account)
        if account.admin?
            return publicities
        end

        return publicities.slice(:listed, :unlisted)
        # TODO: Private Chat
    end
end
