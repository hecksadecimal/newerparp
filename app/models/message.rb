class Message < ApplicationRecord
    self.inheritance_column = 'inheritance_type'

    scope :between, -> (start, finish) {
        where("posted BETWEEN ? AND ?", start, finish)
    }
    
    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat_user, query_constraints: [:chat_id, :user_id]
    belongs_to :chat
end
  