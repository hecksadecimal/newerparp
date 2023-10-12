json.prettify! if %w(1 yes true).include?(params["pretty"])
json.extract! chat, :id, :url, :type, :last_message, :created_at, :updated_at
json.url chat_url(chat, format: :json)
