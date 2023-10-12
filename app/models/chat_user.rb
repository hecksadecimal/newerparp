class ChatUser < ApplicationRecord
    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat
end
