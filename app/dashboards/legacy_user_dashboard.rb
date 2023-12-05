require "administrate/base_dashboard"

class LegacyUserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    acronym: Field::String,
    admin_tier_id: Field::Number,
    case: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    color: Field::String,
    confirm_disconnect: Field::Boolean,
    created: Field::DateTime,
    date_of_birth: Field::DateTime,
    default_character_id: Field::Number,
    desktop_notifications: Field::Boolean,
    email_address: Field::String,
    email_verified: Field::Boolean,
    enable_activity_indicator: Field::Boolean,
    group: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    group_chat_levels: Field::String,
    group_chat_styles: Field::String,
    last_ip: Field::String.with_options(searchable: false),
    last_online: Field::DateTime,
    last_search_mode: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    name: Field::String,
    password: Field::String,
    pm_age_restriction: Field::Boolean,
    quirk_prefix: Field::String,
    quirk_suffix: Field::String,
    regexes: Field::Text,
    replacements: Field::Text,
    roulette_character_id: Field::Number,
    roulette_search_character_id: Field::Number,
    search_age_restriction: Field::Boolean,
    search_character_id: Field::Number,
    search_filters: Field::String,
    search_levels: Field::String,
    search_style: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    secret_answer: Field::String,
    secret_question: Field::String,
    show_bbcode: Field::Boolean,
    show_preview: Field::Boolean,
    show_system_messages: Field::Boolean,
    show_timestamps: Field::Boolean,
    show_user_numbers: Field::Boolean,
    theme: Field::String,
    timezone: Field::String,
    typing_notifications: Field::Boolean,
    username: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    acronym
    admin_tier_id
    case
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    acronym
    admin_tier_id
    case
    color
    confirm_disconnect
    created
    date_of_birth
    default_character_id
    desktop_notifications
    email_address
    email_verified
    enable_activity_indicator
    group
    group_chat_levels
    group_chat_styles
    last_ip
    last_online
    last_search_mode
    name
    password
    pm_age_restriction
    quirk_prefix
    quirk_suffix
    regexes
    replacements
    roulette_character_id
    roulette_search_character_id
    search_age_restriction
    search_character_id
    search_filters
    search_levels
    search_style
    secret_answer
    secret_question
    show_bbcode
    show_preview
    show_system_messages
    show_timestamps
    show_user_numbers
    theme
    timezone
    typing_notifications
    username
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    acronym
    admin_tier_id
    case
    color
    confirm_disconnect
    created
    date_of_birth
    default_character_id
    desktop_notifications
    email_address
    email_verified
    enable_activity_indicator
    group
    group_chat_levels
    group_chat_styles
    last_ip
    last_online
    last_search_mode
    name
    password
    pm_age_restriction
    quirk_prefix
    quirk_suffix
    regexes
    replacements
    roulette_character_id
    roulette_search_character_id
    search_age_restriction
    search_character_id
    search_filters
    search_levels
    search_style
    secret_answer
    secret_question
    show_bbcode
    show_preview
    show_system_messages
    show_timestamps
    show_user_numbers
    theme
    timezone
    typing_notifications
    username
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
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how legacy users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(legacy_user)
  #   "LegacyUser ##{legacy_user.id}"
  # end
end
