require "bbcode-rails/version"

module BBCode
  class ParseError < StandardError
  end

  @tags = {}
  def self.tags
    @tags
  end

  def self.get_tag_by_name name
    if defined?(Rails) && Rails.env.development?
      begin
        "#{name}_tag".camelize.constantize
      rescue NameError
      end
    end
    @tags["#{name.to_s.downcase}tag"]
  end

  def self.parse str, raise_error=false
    str = str.dup

    str.gsub!('&', '&amp;')
    str.gsub!('<', '&lt;')
    str.gsub!('>', '&gt;')
    str.gsub!('"', '&quot;')
    str.gsub!("'", '&apos;')

    # Let's iterate over the pieces to build a tree
    # It works like this:
    # For each object you have two things:
    #   1. It is a tag name a la [img]
    #   2. It is a simple string, something like 'Hello'
    #
    # Now, we want a tree that looks like this
    #
    # -> |
    #    | ImgTag src: http://adada
    #    | String This cat
    #    | BTag is -> |
    #                 | ITag funny!
    # In the end we just recursively append

    result = []

    tag_open          = /\[/
    tag_close         = /\]/
    tag_close_prefix  = /\//
    tag_arg           = /=/
    tag_arg_delim     = /&quot;/
    tag_name          = /[-?!\|:\.\\\/_a-zA-Z0-9\s]/

    current_state = :text
    current_tag = result

    begin
      pos = 0
      while pos < str.length
        case current_state
        when :text
          tmp = ""
          # We iterate through the string either until the end or if we find a [
          while not str[pos] =~ tag_open and pos < str.length
            tmp << str[pos]
            pos = pos.next
          end
          current_tag << tmp
          current_state = :tag_name if pos < str.length # Okay, we have found the beginning of a possible tag!
          pos = pos.next
        when :tag_name
          name = ""
          if str[pos-1] =~ tag_open and str[pos] =~ tag_close_prefix
            # It's a closing tag!
            # Let's check if it applies to our current tag..

            broke_out = false
            tag = current_tag
            until tag.is_a? Array
              len = tag.name.length
              if str[pos+1,len] && str[pos+1,len].downcase == tag.name and str[pos+len+1] =~ tag_close
                # If it's the current one?
                if current_tag == tag
                  current_tag = tag.parent
                  pos += len+1
                  broke_out = true
                  break
                else
                  # It's not the current one! Invalid construct
                  raise BBCode::ParseError, "Invalid nested tags"
                end
              end
              tag = tag.parent
            end

            # It's not a closing tag we recognize, so it's text really!
            # Let's restore this!
            if not broke_out
              current_tag << "[/"
            end
            current_state = :text
            pos = pos.next
            next
          end
          while not (str[pos] =~ tag_close and str[pos] =~ tag_arg and pos < str.length) and str[pos] && str[pos].downcase =~ tag_name
            name << str[pos]
            pos = pos.next
          end

          if str[pos] =~ tag_arg or str[pos] =~ tag_close
            if self.get_tag_by_name(name)
              new_tag = self.get_tag_by_name(name).new(current_tag)
              current_tag  << new_tag
              if new_tag.has_option(:content) or new_tag.has_option(:argument)
                current_tag = new_tag
              end
              if str[pos] =~ tag_arg
                if new_tag.has_option :argument
                  current_state = :tag_arg
                else
                  raise BBCode::ParseError
                end
              else
                current_state = :text
              end
              pos = pos.next
            else
              current_tag << "[#{name}"
              current_state = :text
            end
            next
          end


          # Did we hit the end? Let's get out
          current_tag << name
          current_state = :text
        when :tag_arg
          arg = ""
          while not str[pos] =~ tag_close and pos < str.length
            arg << str[pos]
            pos = pos.next
          end

          current_tag.argument = arg.gsub(/^#{tag_arg_delim}(.*)#{tag_arg_delim}$/, '\1')
          if not current_tag.has_option(:content)
            current_tag = current_tag.parent
          end
          current_state = :text
          pos = pos.next
        else
          pos = pos.next
        end
      end

      result_str = result.map(&:to_s).join('').strip

      # extracted from bb-ruby, which extracted it from Rails ActionPack
      start_tag = ''
      result_str.gsub!(/\r\n?/, "\n")                   # \r\n and \r => \n
      result_str.gsub!(/\n\n+/, "</p>\n\n#{start_tag}") # 2+ newline  => paragraph
      #result_str.gsub!(/([^\n>]\n)(?=[^\n<])/, '\1<br>')# 1 newline   => br
      result_str.insert 0, start_tag
      result_str << ''
    rescue BBCode::ParseError => e
      if raise_error
        raise e
      else
        str
      end
    end
  end

end

class String
  def bbcode_to_html raise_error = false
    BBCode.parse(self, raise_error)
  end
end

require 'bbcode-rails/railtie' if defined?(Rails)
require 'bbcode-rails/tag' unless defined?(Rails)
