# frozen_string_literal: true

module RenderEditorjs
  module Blocks
    class Paragraph < Base
      DEFAULT_OPTIONS = {
        tag: "p"
      }.freeze

      SCHEMA = YAML.safe_load(<<~YAML)
        type: object
        additionalProperties: false
        properties:
          text:
            type: string
          alignment:
            type: string
            enum:
              - align-left
              - align-center
              - align-right
      YAML

      attr_reader :options

      def initialize(options = DEFAULT_OPTIONS)
        @options = options
        super()
      end

      def render(data)
        return unless valid?(data)

        alignment = data["alignment"]
        class_name_str = ""
        if alignment.present?
          class_name_str = [
            class_name_str,
            css_name("__#{alignment}")
          ].join(" ")
        end

        content_tag(options[:tag], class: class_name_str.presence) do
          sanitize(data["text"]).html_safe
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
