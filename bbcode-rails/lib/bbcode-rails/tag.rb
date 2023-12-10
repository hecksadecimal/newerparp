if defined?(Rails)
  class BBCode::Tag < AbstractController::Base
  end
else
  class BBCode::Tag
  end
end


class BBCode::Tag
  if defined?(Rails)
    include AbstractController::Rendering
    include AbstractController::Helpers
    include AbstractController::Translation
    include AbstractController::AssetPaths
    include ActionView::Rendering
    include Rails.application.routes.url_helpers
    self.view_paths = "app/views"
  end

  attr_accessor :parent

  def initialize parent
    @parent = parent
    @content = []
    @argument = ""
  end

  def has_option opt
    self.class.options.include?(opt)
  end

  def get_block
    self.class.block
  end

  def argument= arg
    if !has_option :argument
      raise BBCode::ParseError, "Tried to assign an argument to a tag which takes none, #{name}"
    else
      @argument = arg
    end
  end

  def << c
    if !has_option :content
      raise BBCode::ParseError, "Tried to assign content to a tag which takes none, #{name}"
    else
      @content << c
    end
  end

  def to_s
    if has_option :content
      result = @content.map(&:to_s).join('')
    end
    if has_option(:content) and has_option(:argument)
      self.instance_exec(@argument, result, &get_block)
    elsif has_option :content
      self.instance_exec(result, &get_block)
    elsif has_option :argument
      self.instance_exec(@argument, &get_block)
    else
      self.instance_exec(&get_block)
    end
  end

  def name
    self.class.to_s.downcase.gsub(/tag$/i,'')
  end

  def self.inherited subclass
    # In case we autoreload, remove earlier instances
    BBCode.tags.delete_if {|c| c.to_s == subclass.to_s }
    BBCode.tags[subclass.to_s.downcase] = subclass
  end

  def self.block_options *args
    @options = args
  end

  def self.on_layout &b
    @block = b
  end

  def self.options
    @options ||= []
  end

  def self.block
    @block
  end
end

