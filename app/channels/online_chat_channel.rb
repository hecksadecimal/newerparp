class OnlineChatChannel < ActionCable::Channel::Base
    extend Turbo::Streams::Broadcasts, Turbo::Streams::StreamName
    include Turbo::Streams::StreamName::ClassMethods
    
    def subscribed
        super
    end
    def unsubscribed
        super
    end
end