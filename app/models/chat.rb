class Chat < ApplicationRecord
    self.inheritance_column = 'inheritance_type'

    default_scope { order(last_message: :desc) }
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

    accepts_nested_attributes_for :group_chat
    accepts_nested_attributes_for :chat_users

    
    def add_account(account)
        chat_user = ChatUser.new
        chat_user.account = account
        chat_user.chat = self
        last_chat_user = self.chat_users.unscope(:order).order(number: 'DESC').first
        last_number = 0
        if !last_chat_user.nil?
            last_number = last_chat_user.number
        end
        chat_user.number = last_number + 1
        chat_user.subscribed = false
        chat_user.last_online = DateTime.now
        if !self.group_chat.nil?
            if self.group_chat.autosilence
                chat_user.group = "silent"
            else
                chat_user.group = "user"
            end
        else
            chat_user.group = "user"
        end

        chat_user.name = account.name
        chat_user.acronym = account.acronym
        chat_user.color = account.color
        chat_user.acronym = account.acronym
        chat_user.quirk_prefix = account.quirk_prefix
        chat_user.quirk_suffix = account.quirk_suffix
        chat_user.case = account.case
        chat_user.replacements = account.replacements
        chat_user.regexes = account.regexes
        chat_user.confirm_disconnect = account.confirm_disconnect
        chat_user.desktop_notifications = account.desktop_notifications
        chat_user.show_system_messages = account.show_system_messages
        chat_user.show_bbcode = account.show_bbcode
        chat_user.show_preview = account.show_preview
        chat_user.highlighted_numbers = []
        chat_user.ignored_numbers = []
        chat_user.show_user_numbers = account.show_user_numbers
        chat_user.typing_notifications = account.typing_notifications
        chat_user.show_timestamps = account.show_timestamps
        chat_user.search_character_id = account.search_character_id > 0 ? account.search_character_id : 1

        chat_user.save
    end

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
