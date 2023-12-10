class ImgTag < BBCode::Tag
  block_options :argument

  on_layout do |arg|
    args[1].gsub!(/^javascript:/, '')
    "<img src='#{arg}'>"
  end
end
