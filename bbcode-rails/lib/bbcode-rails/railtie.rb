module BBCode
  class Railtie < Rails::Railtie
    initializer "bbcode_load_tag" do
      require 'bbcode-rails/tag'
    end
  end
end
