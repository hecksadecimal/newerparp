require 'set'

namespace :db do
    namespace :emails do
      # This is for if you want to run all seeds inside db/seeds directory
      task :fix, [:provider] => :environment do |t, args|
        if args.empty? || args[:provider].nil?
            puts "Need a provider. example: google.com"
        end
        account_emails = Account.select(:email).group(:email).having("count(*) > 1").size
        account_emails.each do |email|
            if args[:provider] == "*" || email[0].downcase.end_with?(args[:provider].downcase)
                accounts = Account.where(email: email)
                accounts.each do |account|
                    split_email = account.email.split("@")
                    new_email = "#{split_email.first}+#{account.username}@#{split_email.last.downcase}"
                    puts new_email
                    account.email = "temporary@beta.msparp.chat"
                    account.skip_confirmation!
                    account.skip_reconfirmation!
                    account.save

                    account.email = new_email
                    account.skip_confirmation!
                    account.skip_reconfirmation!
                    account.save
                end
            end
        end
      end

      task :providers => :environment do
        account_emails = Account.select(:email).group(:email).having("count(*) > 1").size
        duplicates = []

        account_emails.each do |email|
            duplicates << email[0].split("@").last.downcase
        end

        provider_set = duplicates.to_set

        puts provider_set
      end

      task :broken => :environment do
        accounts = Account.where("email like ?", "%@*")
        accounts.each do |account|
            puts account.username
        end
      end

      task :confirm => :environment do
        accounts = Account.where("confirmed_at IS NULL")

        accounts.each do |account|
            puts "#{account.username} - #{account.unconfirmed_email}"
            account.skip_confirmation!
            account.skip_reconfirmation!
            account.save
        end
      end
    end
end