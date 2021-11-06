# frozen_string_literal: true

module RenderEditorjs
  module Blocks
    # Compatible with https://github.com/editor-js/header
    class Header < Base
      SCHEMA = YAML.safe_load(<<~YAML)
        type: object
        additionalProperties: false
        properties:
          text:
            type: string
          level:
            type: number
            enum: [1,2,3,4,5,6]
          alignment:
            type: string
            enum:
              - left
              - center
              - right
        required:
        - text
        - level
      YAML

      def render(data)
        return unless valid?(data)

        alignment = data["alignment"]
        css_class = alignment ? "align-#{alignment}" : nil
        content_tag(:"h#{data["level"]}", sanitize(data["text"]).html_safe, class: css_class)
      end

      def sanitize(text)
        Sanitize.fragment(text, remove_contents: true).strip
      end
    end
  end
end
