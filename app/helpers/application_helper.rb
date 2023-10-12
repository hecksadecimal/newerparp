module ApplicationHelper
    include Pagy::Frontend

    def lower_bbcode(input_text)
        pattern = /\[([a-zA-Z]+)(=(?:[^\]]+))?]/i

        result = input_text.gsub(pattern) do |match|
            tag_name = $1.downcase  
            argument = $2
            "[#{tag_name}#{argument}]"
        end

        result
    end

    def raw_tag_sanitize(input_text)
        input_text.gsub(/\[raw\](?<content>.*?)\[\/raw\]/im) do |match|
            content = $~[:content]
            "[raw]#{content.gsub(/\[/, '&#91;').gsub(/\]/, '&#93;')}[/raw]"
        end
    end

    def raw_tag_desanitize(input_text)
        input_text.gsub(/\<raw\>(?<content>.*?)\<\/raw\>/im) do |match|
            content = $~[:content]
            "<raw>#{content.gsub("&amp;#91;", "\[" ).gsub("&amp;#93;", "\]")}</raw>"
        end
    end
end
