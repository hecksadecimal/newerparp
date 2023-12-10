# BBCode for Rails

[![Gem Version](https://badge.fury.io/rb/bbcode-rails.svg)](http://badge.fury.io/rb/bbcode-rails)

`bbcode-rails` is a gem for simple integration of BBCode into your application.
It does not assume your feature scope and thus does not include every tag out
there. However, for ease of developement several BBCode tags are included,
namely:

- Italics `[i] Italics [/i]`
- Bold `[b] Bold [/b]`
- Quote `[quote=ID-Name] You can Quote me[/quote]`
- Image `[img=https://i.imgur.com/V8G8dKg.gif]` or `[img]https://i.imgur.com/V8G8dKg.gif[/img]`


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bbcode-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bbcode-rails

## Usage

To keep developement simple and easy to understand all tag definitions are found
in `app/bbcode/`. It is one file per tag.

#### Note

While in development the tags are loaded on use, in production they are then
eager loaded.

### Creating a new tag

You can use the bbcode generator to quickly setup a new tag, simple run

    $ rails generate bb_code:tag tagname

For example if we want to create a bbcode tag to easily link to a user

    $ rails generate bb_code:tag user

This will create `app/bbcode/user_tag.rb`.

```ruby
#app/bbcode/user.rb

class UserTag < BBCode::Tag
  # If your block uses an argument or can have content add the following line
  # with your needed option
  # block_options :argument, :content

  # Be sure to put in only the arguments that you need.
  # So if you only take an argument, remove contents, same the other way around.
  # However if you have both, they have to be in the order of `arg, contents`
  on_layout do |arg, contents|
    "TODO: Implement user tag"
  end
end
```

You could now add something like:

```ruby
#app/bbcode/user.rb

class UserTag < BBCode::Tag
  # If your block uses an argument or can have content add the following line
  # with your needed option
  # block_options :argument, :content
  block_options :argument
  on_layout do |arg|
    user = User.find_by_id(arg)
    render partial: 'shared/userquote', locals: { user: user }
  end
end
```

Of course, the limitations are your knowledge in ruby and rails :)

### Transforming a BBCode string into HTML

Just call `bbcode_to_html` on any string.

```ruby
#> User.all.first.bio
"[i]Hello [b]Everyone[/b][/i]"
#> User.all.first.bio.bbcode_to_html
=> "<em>Hello <strong>Everyone</strong></em>"
```

## Contributing

1. Fork it ( https://github.com/TheNeikos/bbcode-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
