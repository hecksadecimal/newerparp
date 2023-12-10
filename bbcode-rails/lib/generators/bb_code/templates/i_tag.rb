class ITag < BBCode::Tag
  block_options :content

  on_layout do |contents|
    "<em>#{contents}</em>"
  end
end

