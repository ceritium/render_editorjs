# frozen_string_literal: true

module RenderEditorjs
  class Validator
    attr_reader :data, :schema, :errors

    def initialize(data, schema)
      @data = data
      @schema = schema

      @errors = []
    end

    def valid?
      validate!
    rescue JSON::Schema::ValidationError => e
      @errors << e.message

      false
    end

    def validate!
      JSON::Validator.validate!(schema, data)
    end
  end
end
