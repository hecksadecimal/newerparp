class OnlineChatChannel < Turbo::StreamsChannel
    extend Turbo::Streams::Broadcasts, Turbo::Streams::StreamName
    include Turbo::Streams::StreamName::ClassMethods
    
    def subscribed
        chat_accounts_online = Kredis.unique_list verified_stream_name_from_params
        chat_accounts_online << current_account.id
    end
    def unsubscribed
        chat_accounts_online = Kredis.unique_list verified_stream_name_from_params
        chat_accounts_online.remove current_account.id
    end
end