# frozen_string_literal: true

module RenderEditorjs
  module Blocks
    # Render for https://github.com/editor-js/nested-list
    class List < Base
      SCHEMA = YAML.safe_load(<<~YAML)
        type: object
        additionalProperties: false
        definitions:
          Items:
            type: array
            properties:
              content:
                type: string
              items:
                type: Items
        properties:
          style:
            type: string
            pattern: ^(un)?ordered$
          items:
            type: Items
      YAML

      attr_reader :options

      def render(data)
        return unless valid?(data)

        tag = data["style"] == "unordered" ? :ul : :ol
        render_list(tag, data["items"])
      end

      def render_list(tag, items)
        return "" unless items

        content_tag(tag) do
          children_tag_string = ""
          items.each do |v|
            item = sanitize(v["content"])
            item << render_list(tag, v["items"]) if v["items"]
            children_tag_string += content_tag(:li, item.html_safe)
          end
          children_tag_string.html_safe
        end
      end

      def safe_tags
        {
          "b" => nil,
          "i" => nil,
          "u" => ["class"],
          "del" => ["class"],
          "a" => ["href"],
          "mark" => ["class"],
          "code" => ["class"]
        }
      end

      def sanitize(text)
        Sanitize.fragment(
          text,
          elements: safe_tags.keys,
          attributes: safe_tags.select { |_k, v| v },
          remove_contents: true
        )
      end
    end
  end
end
