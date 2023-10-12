class AdminTier < ApplicationRecord
    has_many :accounts
    has_many :permissions, class_name: "AdminTierPermission"
end
  