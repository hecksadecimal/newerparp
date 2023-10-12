json.prettify! if %w(1 yes true).include?(params["pretty"])
json.extract! message, :id, :posted
json.url message_url(message, format: :json)
