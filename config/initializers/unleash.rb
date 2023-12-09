Unleash.configure do |config|
    config.app_name = "Newerparp"
    config.url      = ENV.fetch("UNLEASH_API") { "" }
    config.custom_http_headers = {'Authorization': ENV.fetch("UNLEASH_KEY") { "" }}
    config.instance_id = ENV.fetch("UNLEASH_INSTANCE_ID") { "" }
    config.logger   = Rails.logger
end
  
UNLEASH = Unleash::Client.new