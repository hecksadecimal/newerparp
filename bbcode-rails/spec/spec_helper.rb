$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bbcode-rails'

class ITag < BBCode::Tag
  block_options :content

  on_layout do |content|
    "<em>#{content}</em>"
  end
end

class BTag < BBCode::Tag
  block_options :content

  on_layout do |content|
    "<strong>#{content}</strong>"
  end
end

class BrTag < BBCode::Tag
  on_layout do |args|
    "<br>"
  end
end

class UserTag < BBCode::Tag
  block_options :content, :argument

  on_layout do |args|
    "<p>Name: #{args}</p>"
  end
end

class QuoteTag < BBCode::Tag
  block_options :argument, :content

  on_layout do |args, content|
    <<OA
<p>
Text: #{content}
</p>
<em>
User: #{args}
</em>
OA
  end
end
