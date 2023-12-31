class OnlineChannel < ActionCable::Channel::Base
    extend Turbo::Streams::Broadcasts, Turbo::Streams::StreamName
    include Turbo::Streams::StreamName::ClassMethods
    
    def subscribed
        accounts_online = Kredis.unique_list "accounts_online"
        accounts_online << current_account.id

        account = Account.find(current_account.id)
        account.last_seen_at = DateTime.now
        account.save
    end

    def unsubscribed
        accounts_online = Kredis.unique_list "accounts_online"
        accounts_online.remove current_account.id
    end
end