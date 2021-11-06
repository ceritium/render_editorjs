# frozen_string_literal: true

module RenderEditorjs
  module Blocks
    # Compatible with default Paragraph and paragraph-with-aligment
    # https://github.com/kaaaaaaaaaaai/paragraph-with-alignment
    class Paragraph < Base
      DEFAULT_OPTIONS = {
        tag: "p"
      }.freeze

      SAFE_TAGS = {
        "b" => nil,
        "i" => nil,
        "u" => ["class"],
        "del" => ["class"],
        "a" => ["href"],
        "mark" => ["class"],
        "code" => ["class"]
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
              - left
              - center
              - right
      YAML

      attr_reader :options

      def initialize(options = DEFAULT_OPTIONS)
        @options = options
        super()
      end

      def render(data)
        return unless valid?(data)

        alignment = data["alignment"]
        css_class = alignment ? "align-#{alignment}" : nil
        content_tag(options[:tag], class: css_class) do
          sanitize(data["text"]).html_safe
        end
      end

      def sanitize(text)
        Sanitize.fragment(
          text,
          elements: SAFE_TAGS.keys,
          attributes: SAFE_TAGS.select { |_k, v| v },
          remove_contents: true
        )
      end
    end
  end
end
