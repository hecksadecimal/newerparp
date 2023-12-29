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

    after_update_commit -> { 
        broadcast_replace_to "chat_#{self.id}", target: "chat_#{self.id}_details", partial: "chats/details", locals: {chat: self.chat}

    }

    def self.publicities_for_account(account)
        if account.admin?
            return publicities
        end

        return publicities.slice(:listed, :unlisted)
        # TODO: Private Chat
    end
end
