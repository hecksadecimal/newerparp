# frozen_string_literal: true

class DeviseCreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      # Custom Fields
      t.string  :username,                        null: false, default: ""
      t.enum    :group,                           null: false, enum_type: "users_group"
      t.integer :default_character_id
      t.enum    :last_search_mode,                null: false, enum_type: "user_last_search_mode"
      t.integer :roulette_search_character_id,    null: false
      t.integer :roulette_character_id
      t.integer :search_character_id,             null: false
      t.string  :name,                            limit: 50, null: false
      t.string  :acronym,                         limit: 15, null: false
      t.string  :color,                           limit: 6, null: false
      t.string  :quirk_prefix,                    limit: 2000, null: false
      t.string  :quirk_suffix,                    limit: 2000, null: false
      t.enum    :case,                            null: false, enum_type: "\"case\""
      t.text    :replacements,                    null: false
      t.text    :regexes,                         null: false
      t.enum    :search_style,                    null: false, enum_type: "user_search_style"
      t.string  :group_chat_styles,               limit: 50, null: false, array: true
      t.string  :group_chat_levels,               limit: 50, null: false, array: true
      t.boolean :confirm_disconnect,              null: false
      t.boolean :desktop_notifications,           null: false
      t.boolean :show_system_messages,            null: false
      t.boolean :show_bbcode,                     null: false
      t.boolean :show_preview,                    null: false
      t.boolean :typing_notifications,            default: true, null: false
      t.string  :timezone,                        limit: 255
      t.string  :theme,                           limit: 255
      t.integer :admin_tier_id
      t.string  :search_filters,                  limit: 50, default: [], null: false, array: true
      t.boolean :show_timestamps,                 default: false, null: false
      t.boolean :show_user_numbers,               default: true, null: false
      t.string  :search_levels,                   limit: 50, default: ["sfw"], null: false, array: true
      t.boolean :enable_activity_indicator,       default: true, null: false
      t.datetime :date_of_birth,                  precision: nil
      t.boolean :search_age_restriction,          default: false, null: false
      t.boolean :pm_age_restriction,              default: false, null: false

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :accounts, :username,             unique: true

    add_index :accounts, :email
    add_index :accounts, :reset_password_token, unique: true
    add_index :accounts, :confirmation_token,   unique: true
    # add_index :mxrp_users, :unlock_token,         unique: true
  end
end
