# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::Blocks::HeaderTest < Minitest::Test
  Block = RenderEditorjs::Blocks::Header

  test "#render valid input" do
    output = Block.new.render("text" => "hello", "level" => 1)
    assert_equal "<h1>hello</h1>", output
  end

  test "#render with valid aligment" do
    output = Block.new.render("text" => "hello", "level" => 1, "alignment" => "center")
    assert_equal '<h1 class="align-center">hello</h1>', output
  end

  test "#render with invalid alignment" do
    output = Block.new.render("text" => "hello", "level" => 1, "alignment" => "invalid")
    assert_nil output
  end
end
