# frozen_string_literal: true

require "action_view"
require "action_view/helpers"
require "sanitize"

module RenderEditorjs
  module Blocks
    class Base
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::TextHelper

      # ActionView::Helpers::TagHelper requires output_buffer accessor
      attr_accessor :raw, :output_buffer

      def valid?(data)
        validator(data).valid?
      end

      def validator(data)
        Validator.new(data, self.class::SCHEMA)
      end
    end
  end
end
