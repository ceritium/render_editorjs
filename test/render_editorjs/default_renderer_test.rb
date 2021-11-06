# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::DefaultRendererTest < Minitest::Test
  test "initialize with default mapping" do
    renderer = RenderEditorjs::DefaultRenderer.new
    assert_equal RenderEditorjs::DefaultRenderer::DEFAULT_MAPPING, renderer.mapping
  end

  test "initialize merge mappings" do
    renderer = RenderEditorjs::DefaultRenderer.new("paragraph" => :dummy, "another" => :foo)
    expected_mapping = RenderEditorjs::DefaultRenderer::DEFAULT_MAPPING
    expected_mapping =  expected_mapping.merge("paragraph" => :dummy, "another" => :foo)

    assert_equal expected_mapping, renderer.mapping
  end
end
