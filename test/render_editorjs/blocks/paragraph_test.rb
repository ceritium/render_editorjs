# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::Blocks::ParagraphTest < Minitest::Test
  instance = RenderEditorjs::Blocks::Paragraph.new

  valid_data = {
    "text" => "hello world"
  }

  invalid_data = {
    "invalid" => "data"
  }

  test "#render" do
    assert_equal "<p>hello world</p>", instance.render(valid_data)
    assert_nil instance.render(invalid_data)
  end

  test "#valid?" do
    assert instance.valid?(valid_data)
    refute instance.valid?(invalid_data)
  end
end
