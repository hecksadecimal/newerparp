class ChatUser < ApplicationRecord
    self.primary_key = [:chat_id, :user_id]

    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat
    has_many :messages, query_constraints: [:chat_id, :user_id]
end
