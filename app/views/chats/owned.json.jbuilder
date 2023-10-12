json.prettify! if %w(1 yes true).include?(params["pretty"])
json.array! @chats, partial: "chats/chat", as: :chat
