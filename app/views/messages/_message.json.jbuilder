json.prettify! if %w(1 yes true).include?(params["pretty"])
json.extract! message, :id, :text, :type, :posted
json.number message.chat_user.number
