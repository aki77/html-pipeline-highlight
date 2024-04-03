require 'html_pipeline'

class HTMLPipeline
  class HighlightFilter < NodeFilter
    DEFAULT_IGNORED_ANCESTOR_TAGS = %w[pre code a style script].freeze
    DEFAULT_CLASS_NAME = 'highlight'

    def selector
      Selma::Selector.new(match_text_within: "*", ignore_text_within: DEFAULT_IGNORED_ANCESTOR_TAGS)
    end

    def handle_text_chunk(text)
      text.replace(apply_filter(text.to_s), as: :html)
    end

    def apply_filter(content)
      content.gsub(context[:highlight_pattern]) do |text|
        if converter
          converter.call(Regexp.last_match)
        else
          %(<span class="#{class_name}">#{ERB::Util.html_escape(text)}</span>)
        end
      end
    end

    def validate
      needs(:highlight_pattern)
    end

    private

    def class_name
      context.fetch(:highlight_class_name, DEFAULT_CLASS_NAME)
    end

    def converter
      context[:highlight_converter]
    end
  end
end
