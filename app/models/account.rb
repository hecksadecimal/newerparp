class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable
  
  belongs_to :admin_tier
  has_many :permissions, through: :admin_tier

  has_many :messages
  
  has_many :chat_users, foreign_key: 'user_id'
  has_many :chats, through: :chat_users do
    def subscribed 
      where("chat_users.subscribed = ?", true)
    end
  end

  def ability
    @ability ||= Ability.new(self)
  end

  def admin?
    !admin_tier.nil?
  end
end
