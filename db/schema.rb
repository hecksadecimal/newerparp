# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_31_042406) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "admin_tier_permissions_permission", ["permissions", "search_characters", "announcements", "broadcast", "user_list", "groups", "log", "spamless", "ip_bans", "reset_password", "email_bans"]
  create_enum "case", ["first-letter", "proper", "inverted", "lower", "title", "alternating", "normal", "alt-lines", "upper"]
  create_enum "chat_users_group", ["mod", "mod2", "mod3", "silent", "user", "mod1"]
  create_enum "chats_type", ["group", "pm", "requested", "roulette", "searched"]
  create_enum "group_chats_level", ["sfw", "nsfw", "nsfw-extreme", "nsfws", "nsfwv"]
  create_enum "group_chats_publicity", ["listed", "unlisted", "pinned", "admin_only", "private"]
  create_enum "group_chats_style", ["script", "paragraph", "either"]
  create_enum "log_markers_type", ["page_with_system_messages", "page_without_system_messages"]
  create_enum "messages_type", ["ic", "ooc", "me", "join", "disconnect", "timeout", "user_info", "user_group", "user_action", "chat_meta", "search_info", "spamless"]
  create_enum "requests_status", ["draft", "posted"]
  create_enum "spamless_filter_types", ["banned_names", "blacklist", "warnlist"]
  create_enum "tags_type", ["fandom", "type", "character_wanted", "gender_wanted", "gender", "fandom_wanted", "character", "maturity", "misc", "trigger"]
  create_enum "user_last_search_mode", ["roulette", "search"]
  create_enum "user_search_level", ["sfw", "nsfw", "nsfwe"]
  create_enum "user_search_style", ["script", "paragraph", "either"]
  create_enum "users_group", ["guest", "active", "admin", "banned", "admin1", "admin2", "new", "deactivated"]

  create_table "accounts", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.enum "group", default: "active", null: false, enum_type: "users_group"
    t.integer "default_character_id"
    t.enum "last_search_mode", default: "search", null: false, enum_type: "user_last_search_mode"
    t.integer "roulette_search_character_id", default: 0, null: false
    t.integer "roulette_character_id"
    t.integer "search_character_id", default: 0, null: false
    t.string "name", limit: 50, default: "Anonymous"
    t.string "acronym", limit: 15, default: "??"
    t.string "color", limit: 6, default: "000000"
    t.string "quirk_prefix", limit: 2000, default: "", null: false
    t.string "quirk_suffix", limit: 2000, default: "", null: false
    t.enum "case", default: "normal", null: false, enum_type: ""case""
    t.text "replacements", default: "", null: false
    t.text "regexes", default: "", null: false
    t.enum "search_style", default: "either", null: false, enum_type: "user_search_style"
    t.string "group_chat_styles", limit: 50, default: [], null: false, array: true
    t.string "group_chat_levels", limit: 50, default: [], null: false, array: true
    t.boolean "confirm_disconnect", default: true, null: false
    t.boolean "desktop_notifications", default: false, null: false
    t.boolean "show_system_messages", default: true, null: false
    t.boolean "show_bbcode", default: true, null: false
    t.boolean "show_preview", default: false, null: false
    t.boolean "typing_notifications", default: true, null: false
    t.string "timezone", limit: 255
    t.string "theme", limit: 255
    t.integer "admin_tier_id"
    t.string "search_filters", limit: 50, default: [], null: false, array: true
    t.boolean "show_timestamps", default: false, null: false
    t.boolean "show_user_numbers", default: true, null: false
    t.string "search_levels", limit: 50, default: ["sfw"], null: false, array: true
    t.boolean "enable_activity_indicator", default: true, null: false
    t.datetime "date_of_birth", precision: nil
    t.boolean "search_age_restriction", default: false, null: false
    t.boolean "pm_age_restriction", default: false, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_seen_at"
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_log_entries", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.datetime "date", precision: nil, null: false
    t.integer "action_user_id", null: false
    t.string "type", limit: 50, null: false
    t.text "description"
    t.integer "affected_user_id"
    t.integer "chat_id"
  end

  create_table "admin_tier_permissions", primary_key: ["admin_tier_id", "permission"], force: :cascade do |t|
    t.integer "admin_tier_id", null: false
    t.enum "permission", null: false, enum_type: "admin_tier_permissions_permission"
  end

  create_table "admin_tiers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "alembic_version", id: false, force: :cascade do |t|
    t.string "version_num", limit: 32, null: false
  end

  create_table "announcements", force: :cascade do |t|
    t.string "title"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_announcements_on_account_id"
  end

  create_table "bans", primary_key: ["user_id", "chat_id"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chat_id", null: false
    t.integer "creator_id", null: false
    t.datetime "created", precision: nil, null: false
    t.datetime "expires", precision: nil
    t.text "reason"
    t.index ["chat_id"], name: "bans_chat_id"
    t.index ["user_id"], name: "bans_user_index"
  end

  create_table "beta_codes", force: :cascade do |t|
    t.text "code"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origin", default: ""
    t.index ["account_id"], name: "index_beta_codes_on_account_id"
  end

  create_table "blocks", primary_key: ["blocking_user_id", "blocked_user_id"], force: :cascade do |t|
    t.integer "blocking_user_id", null: false
    t.integer "blocked_user_id", null: false
    t.datetime "created", precision: nil, null: false
    t.text "reason"
    t.integer "chat_id"
    t.index ["blocking_user_id"], name: "blocking_user_id_indx"
  end

  create_table "character_tags", primary_key: ["character_id", "tag_id"], force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "tag_id", null: false
    t.string "alias", limit: 50
    t.index ["tag_id"], name: "character_tags_tag_id"
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", limit: 50, null: false
    t.integer "search_character_id", null: false
    t.string "shortcut", limit: 15
    t.string "name", limit: 50, null: false
    t.string "acronym", limit: 15, null: false
    t.string "color", limit: 6, null: false
    t.string "quirk_prefix", limit: 2000, null: false
    t.string "quirk_suffix", limit: 2000, null: false
    t.enum "case", null: false, enum_type: ""case""
    t.text "replacements", null: false
    t.text "regexes", null: false
    t.index ["user_id"], name: "characters_user_id"
  end

  create_table "chat_users", primary_key: ["chat_id", "user_id"], force: :cascade do |t|
    t.integer "chat_id", null: false
    t.integer "user_id", null: false
    t.integer "number", null: false
    t.boolean "subscribed", null: false
    t.datetime "last_online", precision: nil, null: false
    t.enum "group", null: false, enum_type: "chat_users_group"
    t.string "name", limit: 50, null: false
    t.string "acronym", limit: 15, null: false
    t.string "color", limit: 6, null: false
    t.string "quirk_prefix", limit: 2000, null: false
    t.string "quirk_suffix", limit: 2000, null: false
    t.enum "case", null: false, enum_type: ""case""
    t.text "replacements", null: false
    t.text "regexes", null: false
    t.boolean "confirm_disconnect", null: false
    t.boolean "desktop_notifications", null: false
    t.boolean "show_system_messages", null: false
    t.boolean "show_bbcode", null: false
    t.boolean "show_preview", null: false
    t.integer "highlighted_numbers", null: false, array: true
    t.integer "ignored_numbers", null: false, array: true
    t.boolean "typing_notifications", default: true, null: false
    t.text "draft"
    t.string "theme", limit: 255
    t.boolean "show_timestamps", default: false, null: false
    t.text "notes"
    t.string "title", limit: 50
    t.boolean "show_user_numbers", default: true, null: false
    t.boolean "enable_activity_indicator", default: true, null: false
    t.integer "search_character_id", default: 1, null: false
    t.index ["chat_id", "number"], name: "chat_users_number_unique", unique: true
    t.index ["chat_id"], name: "chat_users_chat_id"
    t.index ["search_character_id"], name: "search_char_id"
    t.index ["user_id", "subscribed"], name: "chat_users_user_id_subscribed"
  end

  create_table "chats", id: :serial, force: :cascade do |t|
    t.string "url", limit: 101
    t.enum "type", null: false, enum_type: "chats_type"
    t.datetime "created", precision: nil, null: false
    t.datetime "last_message", precision: nil, null: false
    t.index ["last_message"], name: "chats_last_message_index"
    t.unique_constraint ["url"], name: "chats_url_key"
  end

  create_table "email_bans", id: :serial, force: :cascade do |t|
    t.string "pattern", limit: 255, null: false
    t.datetime "date", precision: nil, null: false
    t.integer "creator_id", null: false
    t.string "reason", limit: 255, null: false

    t.unique_constraint ["pattern"], name: "email_bans_pattern_key"
  end

  create_table "fandoms", id: :serial, force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "group_chats", id: :integer, default: nil, force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.text "topic", null: false
    t.text "description", null: false
    t.text "rules", null: false
    t.boolean "autosilence", null: false
    t.enum "style", null: false, enum_type: "group_chats_style"
    t.enum "level", null: false, enum_type: "group_chats_level"
    t.enum "publicity", null: false, enum_type: "group_chats_publicity"
    t.integer "creator_id", null: false
    t.integer "parent_id"
    t.boolean "image_upload", default: false
    t.index ["publicity"], name: "group_chats_publicity_listed", where: "(publicity = ANY (ARRAY['listed'::group_chats_publicity, 'pinned'::group_chats_publicity]))"
  end

  create_table "invites", primary_key: ["user_id", "chat_id"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chat_id", null: false
    t.integer "creator_id"
    t.datetime "created", precision: nil, null: false
    t.boolean "unread", default: true, null: false
  end

  create_table "ip_bans", primary_key: "address", id: :inet, force: :cascade do |t|
    t.datetime "date", precision: nil, null: false
    t.integer "creator_id", null: false
    t.string "reason", limit: 255, null: false
    t.boolean "hidden", default: false, null: false
  end

  create_table "log_markers", primary_key: ["chat_id", "type", "number"], force: :cascade do |t|
    t.integer "chat_id", null: false
    t.enum "type", null: false, enum_type: "log_markers_type"
    t.integer "number", null: false
    t.integer "message_id", null: false
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "chat_id", null: false
    t.integer "user_id"
    t.datetime "posted", precision: nil, null: false
    t.enum "type", null: false, enum_type: "messages_type"
    t.string "color", limit: 6, default: "", null: false
    t.string "acronym", limit: 15, default: "", null: false
    t.string "name", limit: 50, default: "", null: false
    t.text "text", default: "", null: false
    t.string "spam_flag", limit: 50
    t.integer "render_mode", default: 0
    t.index ["chat_id", "posted"], name: "messages_chat_id"
    t.index ["posted"], name: "messages_posted_idx", where: "(spam_flag IS NOT NULL)"
    t.index ["user_id"], name: "messages_user_id"
  end

  create_table "search_character_choices", primary_key: ["user_id", "search_character_id"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "search_character_id", null: false
  end

  create_table "search_character_groups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "order", null: false
    t.integer "fandom_id", default: 1, null: false
  end

  create_table "search_characters", id: :serial, force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.integer "group_id", null: false
    t.integer "order", null: false
    t.string "name", limit: 50, null: false
    t.string "acronym", limit: 15, null: false
    t.string "color", limit: 6, null: false
    t.string "quirk_prefix", limit: 2000, null: false
    t.string "quirk_suffix", limit: 2000, null: false
    t.enum "case", null: false, enum_type: ""case""
    t.text "replacements", null: false
    t.text "regexes", null: false
    t.text "text_preview", null: false
  end

  create_table "spam_flags", id: :serial, force: :cascade do |t|
    t.integer "message_id", null: false
    t.enum "type", null: false, enum_type: "spamless_filter_types"
    t.integer "points"
    t.boolean "muted"
    t.index ["message_id"], name: "t_msg_id_spamflag"
    t.unique_constraint ["message_id"], name: "spam_flags_message_id_key"
  end

  create_table "spamless_filters", id: :serial, force: :cascade do |t|
    t.enum "type", null: false, enum_type: "spamless_filter_types"
    t.text "regex", null: false
    t.integer "points"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.enum "type", null: false, enum_type: "tags_type"
    t.string "name", limit: 50, null: false
    t.integer "synonym_id"
    t.index ["type", "name"], name: "tags_type_name", unique: true
  end

  create_table "user_notes", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "creator_id", null: false
    t.datetime "created", precision: nil, null: false
    t.text "text", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 50, null: false
    t.string "password", limit: 60, null: false
    t.string "secret_question", limit: 50
    t.string "secret_answer", limit: 60
    t.string "email_address", limit: 100
    t.enum "group", null: false, enum_type: "users_group"
    t.datetime "created", precision: nil, null: false
    t.datetime "last_online", precision: nil, null: false
    t.inet "last_ip", null: false
    t.integer "default_character_id"
    t.enum "last_search_mode", null: false, enum_type: "user_last_search_mode"
    t.integer "roulette_search_character_id", null: false
    t.integer "roulette_character_id"
    t.integer "search_character_id", null: false
    t.string "name", limit: 50, null: false
    t.string "acronym", limit: 15, null: false
    t.string "color", limit: 6, null: false
    t.string "quirk_prefix", limit: 2000, null: false
    t.string "quirk_suffix", limit: 2000, null: false
    t.enum "case", null: false, enum_type: ""case""
    t.text "replacements", null: false
    t.text "regexes", null: false
    t.enum "search_style", null: false, enum_type: "user_search_style"
    t.string "group_chat_styles", limit: 50, null: false, array: true
    t.string "group_chat_levels", limit: 50, null: false, array: true
    t.boolean "confirm_disconnect", null: false
    t.boolean "desktop_notifications", null: false
    t.boolean "show_system_messages", null: false
    t.boolean "show_bbcode", null: false
    t.boolean "show_preview", null: false
    t.boolean "typing_notifications", default: true, null: false
    t.string "timezone", limit: 255
    t.string "theme", limit: 255
    t.integer "admin_tier_id"
    t.string "search_filters", limit: 50, default: [], null: false, array: true
    t.boolean "show_timestamps", default: false, null: false
    t.boolean "show_user_numbers", default: true, null: false
    t.string "search_levels", limit: 50, default: ["sfw"], null: false, array: true
    t.boolean "enable_activity_indicator", default: true, null: false
    t.boolean "email_verified", default: false, null: false
    t.datetime "date_of_birth", precision: nil
    t.boolean "search_age_restriction", default: false, null: false
    t.boolean "pm_age_restriction", default: false, null: false
    t.index "lower((username)::text)", name: "users_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_log_entries", "chats", name: "admin_log_entries_chat_id_fkey"
  add_foreign_key "admin_log_entries", "users", column: "action_user_id", name: "admin_log_entries_action_user_id_fkey"
  add_foreign_key "admin_log_entries", "users", column: "affected_user_id", name: "admin_log_entries_affected_user_id_fkey"
  add_foreign_key "admin_tier_permissions", "admin_tiers", name: "admin_tier_permissions_admin_tier_id_fkey"
  add_foreign_key "announcements", "accounts"
  add_foreign_key "bans", "chats", name: "ban_chat_id_fkey", on_delete: :cascade
  add_foreign_key "bans", "users", column: "creator_id", name: "bans_creator_id_fkey"
  add_foreign_key "bans", "users", name: "bans_user_id_fkey"
  add_foreign_key "beta_codes", "accounts"
  add_foreign_key "blocks", "chats", name: "blocks_chat_id_fkey", on_delete: :nullify
  add_foreign_key "blocks", "users", column: "blocked_user_id", name: "blocks_blocked_user_id_fkey"
  add_foreign_key "blocks", "users", column: "blocking_user_id", name: "blocks_blocking_user_id_fkey"
  add_foreign_key "character_tags", "characters", name: "character_tags_character_id_fkey"
  add_foreign_key "character_tags", "tags", name: "character_tags_tag_id_fkey"
  add_foreign_key "characters", "search_characters", name: "characters_search_character_id_fkey"
  add_foreign_key "characters", "users", name: "characters_user_id_fkey", on_delete: :cascade
  add_foreign_key "chat_users", "chats", name: "chat_users_chat_id_fkey", on_delete: :cascade
  add_foreign_key "chat_users", "search_characters", name: "chat_users_search_character_id_fkey"
  add_foreign_key "email_bans", "users", column: "creator_id", name: "email_bans_creator_id_fkey"
  add_foreign_key "group_chats", "chats", column: "id", name: "group_chats_id_fkey", on_delete: :cascade
  add_foreign_key "group_chats", "chats", column: "parent_id", name: "group_chats_parent_id_fkey"
  add_foreign_key "invites", "chats", name: "invites_chat_id_fkey", on_delete: :cascade
  add_foreign_key "invites", "users", column: "creator_id", name: "invites_creator_id_fkey"
  add_foreign_key "invites", "users", name: "invites_user_id_fkey"
  add_foreign_key "ip_bans", "users", column: "creator_id", name: "ip_bans_creator_id_fkey"
  add_foreign_key "log_markers", "chats", name: "log_markers_chat_id_fkey", on_delete: :cascade
  add_foreign_key "log_markers", "messages", name: "log_markers_message_id_fkey", on_delete: :cascade
  add_foreign_key "messages", "chats", name: "messages_chat_id_fkey", on_delete: :cascade
  add_foreign_key "search_character_choices", "search_characters", name: "search_character_choices_search_character_id_fkey"
  add_foreign_key "search_character_choices", "users", name: "search_character_choices_user_id_fkey"
  add_foreign_key "search_character_groups", "fandoms", name: "search_character_groups_fandom_id_fkey"
  add_foreign_key "search_characters", "search_character_groups", column: "group_id", name: "search_characters_group_id_fkey"
  add_foreign_key "spam_flags", "messages", name: "spam_flags_message_id_fkey", on_delete: :cascade
  add_foreign_key "tags", "tags", column: "synonym_id", name: "tags_synonym_id_fkey"
  add_foreign_key "user_notes", "users", column: "creator_id", name: "user_notes_creator_id_fkey"
  add_foreign_key "user_notes", "users", name: "user_notes_user_id_fkey"
  add_foreign_key "users", "admin_tiers", name: "users_admin_tier_id_fkey"
  add_foreign_key "users", "characters", column: "default_character_id", name: "users_default_character_fkey"
  add_foreign_key "users", "characters", column: "roulette_character_id", name: "users_roulette_character_fkey"
  add_foreign_key "users", "search_characters", column: "roulette_search_character_id", name: "users_roulette_search_character_id_fkey"
  add_foreign_key "users", "search_characters", name: "users_search_character_id_fkey"
end
