class BetaKeyStrategy
    def name
      'BetaKey'
    end
  
    def is_enabled?(params = {}, context = nil)
      if context.nil? && context.properties.nil?
        return false
      end

      if context.properties[:betakey].nil? || context.properties[:betakey].empty?
        return false
      end

      return true
    end
end

class AdminStrategy
    def name
      'Admin'
    end

    def is_enabled?(params = {}, context = nil)
      return false unless !context.nil? && !context.properties.nil? && !context.properties.key?("admin") && context.properties[:admin]
      return false unless context.class.name == 'Unleash::Context'
      return true
    end
end

Unleash.configure do |config|
    config.app_name = "Newerparp"
    config.url      = ENV.fetch("UNLEASH_API") { "" }
    config.custom_http_headers = {'Authorization': ENV.fetch("UNLEASH_KEY") { "" }}
    config.instance_id = ENV.fetch("UNLEASH_INSTANCE_ID") { "" }
    config.logger   = Rails.logger

    config.strategies.add(BetaKeyStrategy.new)
    config.strategies.add(AdminStrategy.new)
end
  
UNLEASH = Unleash::Client.new