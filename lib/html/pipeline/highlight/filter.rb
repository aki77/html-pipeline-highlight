require 'html/pipeline'

module HTML
  class Pipeline
    class HighlightFilter < Filter
      IGNORE_PARENTS = %w[pre code a style script].to_set
      DEFAULT_CLASS_NAME = 'highlight'

      def call
        doc.xpath('.//text()').each do |node|
          next if has_ancestor?(node, IGNORE_PARENTS)

          content = node.to_html
          html = apply_filter(content)
          next if html == content

          node.replace(html)
        end
        doc
      end

      def apply_filter(content)
        content.gsub(@context[:highlight_pattern]) do |text|
          %(<span class="#{class_name}">#{ERB::Util.html_escape(text)}</span>)
        end
      end

      def validate
        needs(:highlight_pattern)
      end

      private

      def class_name
        @context[:highlight_class_name] || DEFAULT_CLASS_NAME
      end
    end
  end
end
