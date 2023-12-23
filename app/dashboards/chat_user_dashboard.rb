require "administrate/base_dashboard"

class ChatUserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    account: Field::BelongsTo.with_options(searchable_fields: [:username]),
    acronym: Field::String,
    chat: Field::BelongsTo.with_options(searchable_fields: [:url]),
    color: Field::String.with_options(searchable: false),
    confirm_disconnect: Field::Boolean.with_options(searchable: false),
    desktop_notifications: Field::Boolean.with_options(searchable: false),
    draft: Field::Text.with_options(searchable: false),
    enable_activity_indicator: Field::Boolean.with_options(searchable: false),
    group: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    last_online: Field::DateTime.with_options(searchable: false),
    name: Field::String,
    notes: Field::Text,
    number: Field::Number.with_options(searchable: false),
    quirk_prefix: Field::String.with_options(searchable: false),
    quirk_suffix: Field::String.with_options(searchable: false),
    regexes: Field::Text.with_options(searchable: false),
    replacements: Field::Text.with_options(searchable: false),
    search_character_id: Field::Number.with_options(searchable: false),
    show_bbcode: Field::Boolean.with_options(searchable: false),
    show_preview: Field::Boolean.with_options(searchable: false),
    show_system_messages: Field::Boolean.with_options(searchable: false),
    show_timestamps: Field::Boolean.with_options(searchable: false),
    show_user_numbers: Field::Boolean.with_options(searchable: false),
    subscribed: Field::Boolean,
    theme: Field::String.with_options(searchable: false),
    title: Field::String.with_options(searchable: false),
    typing_notifications: Field::Boolean.with_options(searchable: false)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    account
    name
    number
    chat
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    account
    acronym
    chat
    color
    confirm_disconnect
    desktop_notifications
    draft
    enable_activity_indicator
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
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    acronym
    color
    confirm_disconnect
    desktop_notifications
    draft
    enable_activity_indicator
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
  def display_resource(chat_user)
     "#{chat_user.chat.url}, ##{chat_user.number}"
  end
end
