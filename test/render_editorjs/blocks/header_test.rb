# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::Blocks::HeaderTest < Minitest::Test
  instance = RenderEditorjs::Blocks::Header.new

  valid_data = {
    "text" => "hello world",
    "level" => 1
  }

  test "#render" do
    assert_equal "<h1>hello world</h1>", instance.render(valid_data)
  end
end
