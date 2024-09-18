# frozen_string_literal: true

module RenderEditorjs
  class Document
    include ActionView::Helpers::OutputSafetyHelper

    attr_reader :renderer, :content, :errors

    def initialize(content, renderer = RenderEditorjs::DefaultRenderer.new)
      @renderer = renderer
      @content = content.is_a?(Hash) ? content : parse_json(content)
      @errors = []
    end

    def valid?
      return false unless valid_renderer?

      validate_blocks

      @errors.empty?
    end

    def render
      return "" unless valid_renderer?

      safe_join(
        content["blocks"].map do |block|
          block_renderer = block_renderers(block["type"])
          next unless block_renderer

          block_renderer.render(block["data"])
        end.compact
      )
    end

    private

    def valid_renderer?
      renderer.validator(content).validate!
    rescue JSON::Schema::ValidationError => e
      @errors << e.message

      false
    end

    def validate_blocks
      content["blocks"].each do |block|
        block_renderer = block_renderers(block["type"])
        next unless block_renderer

        validator = block_renderer.validator(block["data"])
        @errors << validator.errors unless validator.valid?
      end
    end

    def block_renderers(block_type)
      @block_renderers ||= {}
      @block_renderers[block_type] ||= renderer.mapping[block_type]
    end

    def parse_json(content)
      JSON.parse(content)
    rescue JSON::ParserError
      nil
    end
  end
end
