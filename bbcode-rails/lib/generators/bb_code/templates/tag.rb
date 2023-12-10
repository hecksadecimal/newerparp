<% module_namespacing do -%>
class <%= name.classify %>Tag < BBCode::Tag
  # If your block uses an argument or can have content add the following line
  # with your needed option
  # block_options :argument, :content

  # Be sure to put in only the arguments that you need.
  # So if you only take an argument, remove contents, same the other way around.
  # However if you have both, they have to be in the order of `arg, contents`
  on_layout do |arg, contents|
    "TODO: Implement <%= name %> tag"
  end
end
<% end -%>
