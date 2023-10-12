json.prettify! if %w(1 yes true).include?(params["pretty"])
json.partial! "chats/chat", chat: @chat
