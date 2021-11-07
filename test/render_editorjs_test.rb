# frozen_string_literal: true

require "test_helper"

class RenderEditorjsTest < Minitest::Test
  test "#render" do
    assert_equal "", RenderEditorjs.render(TestData::VALID_WITHOUT_BLOCK)
    assert_equal "<p>hello world</p>", RenderEditorjs.render(TestData::VALID_WITH_BLOCK)
    assert_equal "<p>hello world</p>", RenderEditorjs.render(TestData::WITH_VALID_AND_INVALID_BLOCKS)
    assert_equal "", RenderEditorjs.render(TestData::EMPTY)
  end
end
