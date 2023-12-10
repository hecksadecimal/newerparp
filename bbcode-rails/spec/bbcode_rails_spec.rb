require 'spec_helper'

describe BBCode do
  it 'has a version number' do
    expect(BBCode::VERSION).not_to be nil
  end

  it 'correctly parses the i tag' do
    expect(ITag).not_to be nil
    expect(BBCode.parse "[i]Test[/i]").to eq "<p><em>Test</em></p>"
  end

  it 'correctly parses the br tag' do
    expect(BrTag).not_to be nil
    expect(BBCode.parse "[br]").to eq "<p><br></p>"
  end

  it 'correctly parses the user tag' do
    expect(UserTag).not_to be nil
    expect(BBCode.parse "[user=Neikos]").to eq "<p><p>Name: Neikos</p></p>"
  end

  it 'correctly parses the quote tag' do
    expect(QuoteTag).not_to be nil
    expect(BBCode.parse "[quote=Neikos]Hello[/quote]").to(
      eq "<p><p>\nText: Hello\n</p>\n<em>\nUser: Neikos\n</em></p>"
    )
  end

  it 'correctly parses several tags' do
    expect(BBCode.parse "[quote=Neikos]Hello [i]Yo[/i][/quote]").to(
      eq "<p><p>\nText: Hello <em>Yo</em>\n</p>\n<em>\nUser: Neikos\n</em></p>"
    )
  end

  it 'correctly parses the user tag with quotes' do
    expect(UserTag).not_to be nil
    expect(BBCode.parse "[user=\"Neikos\"]").to eq "<p><p>Name: Neikos</p></p>"
  end

  it 'cares about invalid tag nesting' do
    expect(ITag).not_to be nil
    expect(BTag).not_to be nil

    expect(BBCode.parse "Hello [i][b]Neikos[/i][/b]").to eq "Hello [i][b]Neikos[/i][/b]"
  end

  it 'doesnt parse unknown tags' do
    expect(BBCode.parse "[what]'s [/up]").to eq "<p>[what]&apos;s [/up]</p>"
  end

  it 'doesnt error out when closing inexisting tags' do
    expect(BTag).not_to be nil
    expect(BBCode.parse "Hey [b] W [/fg] [/b] asd").to eq "<p>Hey <strong> W [/fg] </strong> asd</p>"
  end

  it 'should reraise errors if one chooses so' do
    expect(BTag).not_to be nil
    expect{BBCode.parse "Heya [b=Neikos]", true}.to raise_error(BBCode::ParseError)
  end

  it 'should correctly escape html tags' do
    expect(BBCode.parse "<script>alert('Stealing your data...')</script>").to(
     eq "<p>&lt;script&gt;alert(&apos;Stealing your data...&apos;)&lt;/script&gt;</p>"
   )
  end

  it 'should correctly add newlines' do
    expect(BBCode.parse "Hello!\r\n \n\nNew Paragraph :D").to(
      eq "<p>Hello!\n </p>\n\n<p>New Paragraph :D</p>"
    )
  end

  it 'should not add newlines at the end and beginning of tags' do
    expect(BBCode.parse "Hello!\r\n \n\n[quote=123]\nNew Paragraph :D\n[/quote]").to(
      eq "<p>Hello!\n </p>\n\n<p><p>\nText: \nNew Paragraph :D</p>\n\n<p></p>\n<em>\nUser: 123\n</em></p>"
    )
  end
end
