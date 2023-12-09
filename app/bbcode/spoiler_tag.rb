class SpoilerTag < BBCode::Tag
  # If your block uses an argument or can have content add the following line
  # with your needed option
  block_options :content

  # Be sure to put in only the arguments that you need.
  # So if you only take an argument, remove contents, same the other way around.
  # However if you have both, they have to be in the order of `arg, contents`
  on_layout do |contents|
    "<span class=\"flex break-words whitespace-pre-wrap\">
      <label class=\"swap self-center\">
        <input type=\"checkbox\" />
        <span class=\"swap-on\"><span>#{contents}</span></span>
        <span class=\"swap-off bg-current\"><span class=\"absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-base-100 font-black\">SPOILER</span><span class=\"invisible\">#{contents}</span></span>
      </label>
    </span>"
  end
end
