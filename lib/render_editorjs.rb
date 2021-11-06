# frozen_string_literal: true

require "json-schema"
require "json"
require "yaml"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module RenderEditorjs
  class Error < StandardError; end

  def self.render(content)
    RenderEditorjs::Document.new(RenderEditorjs::DefaultRenderer.new, content).render
  end
end
