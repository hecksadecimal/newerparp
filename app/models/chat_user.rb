class ChatUser < ApplicationRecord
    self.primary_key = [:chat_id, :user_id]
    
    default_scope { order(last_online: :desc) }

    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat
    has_many :messages, query_constraints: [:chat_id, :user_id]

    kredis_boolean :typing, after_change: :update_typing, default: false

    enum group: {
        mod: "mod",
        mod1: "mod1",
        mod2: "mod2",
        mod3: "mod3",
        silent: "silent",
        user: "user"
    }
    
    after_create_commit -> {
        message = Message.new
        message.text = "#{self.name} [#{self.acronym}] joined chat."
        message.account = self.account
        message.chat = self.chat

        message.acronym = ""
        message.name = self.name
        message.color = "000000"
        message.type = "ooc"
        message.posted = Time.now
        
        message.save
    }

    after_update -> {
        self.chat.update_statuses

        if saved_change_to_group?
            if (self.saved_changes[:group] && self.saved_changes[:group][0] == "silent" || self.saved_changes[:group][1] == "silent")
                broadcast_replace_to "chat_#{self.chat_id}_account_#{self.user_id}", target: "input_chat_#{self.chat_id}", partial: "messages/rich_form", locals: {account: self.account, message: Message.new(chat_id: self.chat_id, content: !self.acronym.empty? ? "<p><span><strong>#{self.acronym}:</strong>&nbsp;</span></p>" : "")}
            end
        end
    }

    def update_typing
        typing_users = []
        current_chat_id = self.chat_id
        chat.online_statuses.keys.each do |chat_number|
            chat_user = chat.chat_users.find_by(number: chat_number)
            if chat_user.typing.value == true
                typing_users << chat_user.name
            end 
        end

        broadcast_replace_to "chat_#{self.chat_id}", target: "chat_#{self.chat_id}_#{self.number}_avatar", partial: "chats/avatar", chat_user: self
        broadcast_replace_to "chat_#{self.chat_id}", target: "chat_#{self.chat_id}_typing_mobile", partial: "chats/typing_mobile", :locals => {:chat_id => current_chat_id, :typing_users => typing_users}
    end
end
