class BTag < BBCode::Tag
  block_options :content

  on_layout do |contents|
    "<strong>#{contents}</strong>"
  end
end

