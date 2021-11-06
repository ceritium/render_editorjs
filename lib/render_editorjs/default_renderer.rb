# frozen_string_literal: true

module RenderEditorjs
  # Built in renderer with healthy defaults
  class DefaultRenderer
    SCHEMA = YAML.safe_load(<<~YAML)
      type: object
      additionalProperties: false
      properties:
        time:
          type: number
        blocks:
          type: array
          items:
            type: object
        version:
          type: string
      required:
      - time
      - blocks
      - version
    YAML

    DEFAULT_MAPPING = {
      "paragraph" => RenderEditorjs::Blocks::Paragraph.new,
      "header" => RenderEditorjs::Blocks::Header.new,
      "list" => RenderEditorjs::Blocks::List.new,
      "image" => RenderEditorjs::Blocks::Image.new
    }.freeze

    attr_reader :mapping

    def initialize(custom_mapping = {})
      @mapping = DEFAULT_MAPPING.merge(custom_mapping)
    end
  end
end
