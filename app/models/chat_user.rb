class ChatUser < ApplicationRecord
    self.primary_key = [:chat_id, :user_id]
    
    default_scope { order(last_online: :desc) }

    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat
    has_many :messages, query_constraints: [:chat_id, :user_id]

    kredis_boolean :typing, after_change: :update_typing, default: false

    def update_typing
        broadcast_replace_to "chat_#{self.chat_id}", target: "chat_#{self.chat_id}_#{self.number}_avatar", partial: "chats/avatar", chat_user: self 
    end
end
