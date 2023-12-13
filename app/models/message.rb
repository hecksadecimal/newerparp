class Message < ApplicationRecord
    self.inheritance_column = 'inheritance_type'

    scope :between, -> (start, finish) {
        where("posted BETWEEN ? AND ?", start, finish)
    }
    
    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat_user, query_constraints: [:chat_id, :user_id]
    belongs_to :chat

    after_create_commit -> { 
        broadcast_append_to "chat_#{chat.id}"
        chat.last_message = posted
        chat.save
    }
    after_update_commit -> { broadcast_replace_to "chat_#{chat.id}" }
    after_destroy_commit -> { broadcast_remove_to "chat_#{chat.id}" }
end
  