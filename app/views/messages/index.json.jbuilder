json.prettify! if %w(1 yes true).include?(params["pretty"])
json.array! @messages, partial: "messages/message", as: :message
