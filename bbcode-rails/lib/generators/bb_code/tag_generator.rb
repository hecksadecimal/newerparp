require 'rails/generators'
require 'rails/generators/named_base'

module BbCode
  class TagGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    check_class_collision :suffix => "Tag"

    def create_tag
      template 'tag.rb', File.join('app/bbcode', class_path, "#{file_name}_tag.rb")
    end

    private
    def file_name
      name.underscore
    end
  end
end
