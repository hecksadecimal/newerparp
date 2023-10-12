module ChatsHelper
    def log_pagy_nav(pagy)
        render "chats/log_pagy_nav", pagy: pagy
    end
end
