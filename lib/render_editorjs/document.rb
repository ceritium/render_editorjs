# frozen_string_literal: true

module RenderEditorjs
  class Document
    attr_reader :renderer, :content, :errors

    def initialize(renderer, content)
      @renderer = renderer
      @content = content.is_a?(Hash) ? content : JSON.parse(content)

      @block_renderers = {}
      @errors = []
    end

    def validate_blocks
      content["blocks"].each do |block|
        block_renderer = block_renderers(block["type"])
        next unless block_renderer

        validator = block_renderer.validator(block)
        @errors << validator.errors unless validator.valid?
      end
    end

    def block_renderers(block_type)
      @block_renderers[block_type] ||= renderer.mapping[block_type]
    end

    def validator
      @validator ||= RenderEditorjs::Validator.new(content, renderer.class::SCHEMA)
    end

    def valid?
      validator.validate!
      validate_blocks

      @errors.empty?
    rescue JSON::Schema::ValidationError => e
      @errors << e.message

      false
    end

    def render
      content["blocks"].map do |block|
        block_renderer = block_renderers(block["type"])
        next unless block_renderer

        block_renderer.render(block["data"])
      end.join
    end
  end
end
