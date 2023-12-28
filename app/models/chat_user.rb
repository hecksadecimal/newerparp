class ChatUser < ApplicationRecord
    self.primary_key = [:chat_id, :user_id]
    
    default_scope { order(last_online: :desc) }

    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat
    has_many :messages, query_constraints: [:chat_id, :user_id]

    kredis_boolean :typing, after_change: :update_typing, default: false

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
