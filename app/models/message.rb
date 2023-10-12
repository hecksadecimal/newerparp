class Message < ApplicationRecord
    self.inheritance_column = 'inheritance_type'
    
    belongs_to :account, :foreign_key => 'user_id'
    belongs_to :chat
end
  