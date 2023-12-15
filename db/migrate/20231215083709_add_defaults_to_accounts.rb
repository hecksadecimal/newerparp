class AddDefaultsToAccounts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :accounts, "last_search_mode", "search"
    change_column_default :accounts, "roulette_search_character_id", 0
    change_column_default :accounts, "search_character_id", 0
    change_column_default :accounts, "name", "Anonymous"
    change_column_default :accounts, "acronym", "??"
    change_column_default :accounts, "color", "000000"
    change_column_default :accounts, "quirk_prefix", ""
    change_column_default :accounts, "quirk_suffix", ""
    change_column_default :accounts, "case", "normal"
    change_column_default :accounts, "search_style", "either"
    change_column_default :accounts, "group_chat_styles", []
    change_column_default :accounts, "group_chat_levels", []
    change_column_default :accounts, "confirm_disconnect", true
    change_column_default :accounts, "desktop_notifications", false
    change_column_default :accounts, "show_system_messages", true
    change_column_default :accounts, "show_bbcode", true
    change_column_default :accounts, "show_preview", false
  end
end
