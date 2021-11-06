# frozen_string_literal: true

module RenderEditorjs
  module Blocks
    class Header < Base
      DEFAULT_OPTIONS = {
        alignment: "align-left"
      }.freeze

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
              - align-left
              - align-center
              - align-right
        required:
        - text
        - level
      YAML

      def render(data)
        return unless valid?(data)

        alignment = data["alignment"]
        class_name = ""
        if alignment.present?
          class_name = [
            class_name,
            css_name("__#{alignment}")
          ].join(" ")
        end

        content_tag(:"h#{data["level"]}", sanitize(data["text"]).html_safe, class: class_name.presence)
      end

      def sanitize(text)
        Sanitize.fragment(text, remove_contents: true).strip
      end
    end
  end
end
