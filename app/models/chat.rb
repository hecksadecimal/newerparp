class Chat < ApplicationRecord
    self.inheritance_column = 'inheritance_type'

    default_scope { order(created: :asc) }
    scope :user_searched, lambda { |account|
        searched.joins(:chat_users).where("chat_users.user_id = ?", account.id)
    }
    scope :user_involved, lambda { |account|
        joins(:chat_users).where("chat_users.user_id = ?", account.id)
    }
    scope :owned_by, lambda { |account|
        includes(:group_chat).where(group_chats: {creator_id: account.id})
    }
    scope :listed, -> {
        includes(:group_chat).where(group_chats: {publicity: "listed"})
    }
    scope :listed_or_involved, lambda { |account|
        distinct.joins(:chat_users, :group_chat).where("chat_users.user_id = ? OR group_chats.publicity = 'listed'", account.id)
    }
    
    enum type: { 
        group_chat: "group", 
        pm: "pm", 
        requested: "requested", 
        roulette: "roulette", 
        searched: "searched"
    }

    has_many :chat_users
    has_many :accounts, through: :chat_users, foreign_key: "user_id"
    has_many :messages
    has_one :group_chat, foreign_key: "id", dependent: :destroy

    kredis_hash :online_statuses, after_change: :update_statuses, default: {}


    def update_statuses
        broadcast_replace_to "chat_#{self.id}", target: "chat_#{self.id}_userlist", partial: "chats/userlist", chat: self 
    end

    def created_at
        created
    end
    
    def updated_at
        last_message
    end

    def to_param
        url
    end
end
