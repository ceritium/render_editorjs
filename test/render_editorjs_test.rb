# frozen_string_literal: true

require "test_helper"

class RenderEditorjsTest < Minitest::Test
  test "renderer" do
    RenderEditorjs::DefaultRenderer.new
  end

  test "document" do
    RenderEditorjs::Document.new(RenderEditorjs::DefaultRenderer.new, {})
  end

  valid_json = {
    "time" => 1,
    "blocks" => [],
    "version" => "1.0"
  }

  test "document valid?" do
    doc = RenderEditorjs::Document.new(RenderEditorjs::DefaultRenderer.new, {})
    refute doc.valid?
    assert doc.errors

    doc = RenderEditorjs::Document.new(RenderEditorjs::DefaultRenderer.new, valid_json)
    assert doc.valid?
  end

  valid_json_with_block = {
    "time" => 1,
    "blocks" => [{
      "type" => "paragraph",
      "data" => {
        "text" => "hello world"
      }
    }],
    "version" => "1.0"
  }

  invalid_json_with_block = {
    "time" => 1,
    "blocks" => [{
      "type" => "paragraph",
      "data" => {
        "noop" => "no render me"
      }
    }],
    "version" => "1.0"
  }

  test "document render default paragraph" do
    doc = RenderEditorjs::Document.new(RenderEditorjs::DefaultRenderer.new, valid_json_with_block)
    assert_equal "<p>hello world</p>", doc.render
  end

  test "document render invalid default paragraph" do
    doc = RenderEditorjs::Document.new(RenderEditorjs::DefaultRenderer.new, invalid_json_with_block)
    assert_equal "", doc.render
  end

  test "document validate invalid default paragraph" do
    doc = RenderEditorjs::Document.new(RenderEditorjs::DefaultRenderer.new, invalid_json_with_block)
    refute doc.valid?
  end

  test "document render paragraph with div tag" do
    custom_paragraph = RenderEditorjs::Blocks::Paragraph.new(tag: "div")
    renderer = RenderEditorjs::DefaultRenderer.new("paragraph" => custom_paragraph)
    doc = RenderEditorjs::Document.new(renderer, valid_json_with_block)
    assert_equal "<div>hello world</div>", doc.render
  end

  class CustomParagraphBlock
    SCHEMA = {}.freeze

    def render(_)
      "foo bar"
    end
  end

  test "document render with custom paragraph" do
    custom_paragraph = CustomParagraphBlock.new
    renderer = RenderEditorjs::DefaultRenderer.new("paragraph" => custom_paragraph)
    doc = RenderEditorjs::Document.new(renderer, valid_json_with_block)
    assert_equal "foo bar", doc.render
  end
end
