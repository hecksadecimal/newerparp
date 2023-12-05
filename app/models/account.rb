class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable
  
  belongs_to :admin_tier, optional: true
  has_many :permissions, through: :admin_tier
  has_one :beta_code

  has_many :messages

  enum group: { 
        guest: "guest",
        active: "active",
        admin_user: "admin",
        banned: "banned",
        admin1: "admin1",
        admin2: "admin2",
        new_user: "new",
        deactivated: "deactivated"
  }
  
  has_many :chat_users, foreign_key: 'user_id'
  has_many :chats, through: :chat_users do
    def subscribed 
      where("chat_users.subscribed = ?", true)
    end
  end

  def admin?
    !admin_tier.nil?
  end
end
