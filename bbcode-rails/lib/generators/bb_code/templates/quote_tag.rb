class QuoteTag < BBCode::Tag
  block_options :argument, :content

  on_layout do |arg, contents|
    user = User.find_by_id(arg)
    render(partial: 'bbcode/quote', locals: { user: user, message: contents, user_name: arg })
  end
end
