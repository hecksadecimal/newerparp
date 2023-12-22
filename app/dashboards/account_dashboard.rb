require "administrate/base_dashboard"

class AccountDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    acronym: Field::String,
    admin_tier: Field::BelongsTo,
    beta_code: Field::HasOne,
    case: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    chat_users: Field::HasMany,
    chats: Field::HasMany,
    color: Field::String,
    confirm_disconnect: Field::Boolean,
    confirmation_sent_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    current_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    date_of_birth: Field::DateTime,
    default_character_id: Field::Number,
    desktop_notifications: Field::Boolean,
    email: Field::String,
    enable_activity_indicator: Field::Boolean,
    password: Field::Password,
    encrypted_password: Field::String,
    group: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    group_chat_levels: Field::String,
    group_chat_styles: Field::String,
    last_search_mode: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    last_sign_in_at: Field::DateTime,
    last_sign_in_ip: Field::String,
    messages: Field::HasMany,
    name: Field::String,
    permissions: Field::HasMany,
    pm_age_restriction: Field::Boolean,
    quirk_prefix: Field::String,
    quirk_suffix: Field::String,
    regexes: Field::Text,
    remember_created_at: Field::DateTime,
    replacements: Field::Text,
    reset_password_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    roulette_character_id: Field::Number,
    roulette_search_character_id: Field::Number,
    search_age_restriction: Field::Boolean,
    search_character_id: Field::Number,
    search_filters: Field::String,
    search_levels: Field::String,
    search_style: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    show_bbcode: Field::Boolean,
    show_preview: Field::Boolean,
    show_system_messages: Field::Boolean,
    show_timestamps: Field::Boolean,
    show_user_numbers: Field::Boolean,
    sign_in_count: Field::Number,
    theme: Field::String,
    timezone: Field::String,
    typing_notifications: Field::Boolean,
    unconfirmed_email: Field::String,
    username: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    last_seen_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    username
    email
    unconfirmed_email
    last_seen_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    username
    email
    unconfirmed_email
    last_seen_at
    date_of_birth
    group
    admin_tier
    permissions
    beta_code
    sign_in_count
    timezone
    chat_users
    chats
    last_search_mode
    search_age_restriction
    pm_age_restriction
    roulette_character_id
    roulette_search_character_id
    search_character_id
    default_character_id
    group_chat_levels
    group_chat_styles
    search_filters
    search_levels
    search_style
    name
    acronym
    color
    case
    quirk_prefix
    quirk_suffix
    regexes
    replacements
    current_sign_in_at
    current_sign_in_ip
    last_sign_in_at
    last_sign_in_ip
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    username
    email
    password
    date_of_birth
    admin_tier
    group
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {
    seen: -> (resources) { resources.where.not(last_seen_at: nil).order("last_seen_at ASC") }
  }.freeze

  # Overwrite this method to customize how accounts are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(account)
    "#{account.username}"
  end
end
