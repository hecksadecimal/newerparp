require "administrate/base_dashboard"

class ChatUserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    account: Field::BelongsTo,
    acronym: Field::String,
    case: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    chat: Field::BelongsTo,
    color: Field::String,
    confirm_disconnect: Field::Boolean,
    desktop_notifications: Field::Boolean,
    draft: Field::Text,
    enable_activity_indicator: Field::Boolean,
    group: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    highlighted_numbers: Field::Number,
    ignored_numbers: Field::Number,
    last_online: Field::DateTime,
    name: Field::String,
    notes: Field::Text,
    number: Field::Number,
    quirk_prefix: Field::String,
    quirk_suffix: Field::String,
    regexes: Field::Text,
    replacements: Field::Text,
    search_character_id: Field::Number,
    show_bbcode: Field::Boolean,
    show_preview: Field::Boolean,
    show_system_messages: Field::Boolean,
    show_timestamps: Field::Boolean,
    show_user_numbers: Field::Boolean,
    subscribed: Field::Boolean,
    theme: Field::String,
    title: Field::String,
    typing_notifications: Field::Boolean,
    user_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    account
    acronym
    case
    chat
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    account
    acronym
    case
    chat
    color
    confirm_disconnect
    desktop_notifications
    draft
    enable_activity_indicator
    group
    highlighted_numbers
    ignored_numbers
    last_online
    name
    notes
    number
    quirk_prefix
    quirk_suffix
    regexes
    replacements
    search_character_id
    show_bbcode
    show_preview
    show_system_messages
    show_timestamps
    show_user_numbers
    subscribed
    theme
    title
    typing_notifications
    user_id
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    account
    acronym
    case
    chat
    color
    confirm_disconnect
    desktop_notifications
    draft
    enable_activity_indicator
    group
    highlighted_numbers
    ignored_numbers
    last_online
    name
    notes
    number
    quirk_prefix
    quirk_suffix
    regexes
    replacements
    search_character_id
    show_bbcode
    show_preview
    show_system_messages
    show_timestamps
    show_user_numbers
    subscribed
    theme
    title
    typing_notifications
    user_id
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

  # Overwrite this method to customize how chat users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(chat_user)
  #   "ChatUser ##{chat_user.id}"
  # end
end
