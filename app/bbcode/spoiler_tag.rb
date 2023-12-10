class SpoilerTag < BBCode::Tag
  # If your block uses an argument or can have content add the following line
  # with your needed option
  block_options :content

  # Be sure to put in only the arguments that you need.
  # So if you only take an argument, remove contents, same the other way around.
  # However if you have both, they have to be in the order of `arg, contents`
  on_layout do |contents|
    "<label data-controller=\"spoiler\" class=\"text-current swap\">
        <input class=\"hidden\" type=\"checkbox\" />
        <span class=\"spoiler-off bg-current\"><span class=\"spoiler w-full text-center mx-2 text-base-100 font-black\">SPOILER</span></span>
        <span class=\"spoiler-on hidden px-2 inner-border-2 inner-border-current\">#{contents}</span>
    </label>"
  end
end
