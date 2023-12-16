# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

total = 0
LegacyUser.all.each do |legacy_user|
    account = Account.new

    # Mapping old user table to new
    # Many of these are identical, but a few aren't.
    account.id                           = legacy_user.id
    account.username                     = legacy_user.username
    account.group                        = legacy_user.group
    account.default_character_id         = legacy_user.default_character_id
    account.last_search_mode             = legacy_user.last_search_mode
    account.roulette_search_character_id = legacy_user.roulette_search_character_id
    account.roulette_character_id        = legacy_user.roulette_character_id
    account.search_character_id          = legacy_user.search_character_id
    account.name                         = legacy_user.name
    account.acronym                      = legacy_user.acronym
    account.color                        = legacy_user.color
    account.quirk_prefix                 = legacy_user.quirk_prefix
    account.quirk_suffix                 = legacy_user.quirk_suffix
    account.case                         = legacy_user.case
    account.replacements                 = legacy_user.replacements
    account.regexes                      = legacy_user.regexes
    account.search_style                 = legacy_user.search_style
    account.group_chat_styles            = legacy_user.group_chat_styles
    account.group_chat_levels            = legacy_user.group_chat_levels
    account.confirm_disconnect           = legacy_user.confirm_disconnect
    account.desktop_notifications        = legacy_user.desktop_notifications
    account.show_system_messages         = legacy_user.show_system_messages
    account.show_bbcode                  = legacy_user.show_bbcode
    account.show_preview                 = legacy_user.show_preview
    account.typing_notifications         = legacy_user.typing_notifications
    account.timezone                     = legacy_user.timezone
    account.theme                        = legacy_user.theme
    account.admin_tier_id                = legacy_user.admin_tier_id
    account.search_filters               = legacy_user.search_filters
    account.show_timestamps              = legacy_user.show_timestamps
    account.show_user_numbers            = legacy_user.show_user_numbers
    account.search_levels                = legacy_user.search_levels
    account.enable_activity_indicator    = legacy_user.enable_activity_indicator
    account.date_of_birth                = legacy_user.date_of_birth
    account.search_age_restriction       = legacy_user.search_age_restriction
    account.pm_age_restriction           = legacy_user.pm_age_restriction
    

    # Devise Changes
    account.email                        = legacy_user.email_address ? legacy_user.email_address : "replace_me@mxrp.com"
    account.encrypted_password           = legacy_user.password
    account.skip_confirmation!
    account.save(validate: false)
    total = total + 1
end

printf("#{total} users migrated.\n")
