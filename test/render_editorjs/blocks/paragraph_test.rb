# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::Blocks::ParagraphTest < Minitest::Test
  Block = RenderEditorjs::Blocks::Paragraph

  test "#render valid input with default options" do
    output = Block.new.render("text" => "hello")
    assert_equal "<p>hello</p>", output
  end

  test "#render valid input with custom tag" do
    output = Block.new(tag: "div").render("text" => "hello")
    assert_equal "<div>hello</div>", output
  end

  test "#render with valid aligment" do
    output = Block.new.render("text" => "hello", "alignment" => "center")
    assert_equal '<p class="align-center">hello</p>', output
  end

  test "#render with invalid aligment" do
    output = Block.new.render("text" => "hello", "alignment" => "invalid")
    assert_nil output
  end

  test "#render with b tag" do
    text = "<b>hello</b> world"
    output = Block.new.render("text" => text)
    assert_equal "<p><b>hello</b> world</p>", output
  end

  test "#render with i tag" do
    text = "<i>hello</i> world"
    output = Block.new.render("text" => text)
    assert_equal "<p><i>hello</i> world</p>", output
  end

  test "#render with u tag and class attribute" do
    text = "<u class='test'>hello</u> world"
    output = Block.new.render("text" => text)
    assert_equal '<p><u class="test">hello</u> world</p>', output
  end

  test "#render with del tag and class attribute" do
    text = "<del class='test'>hello</del> world"
    output = Block.new.render("text" => text)
    assert_equal '<p><del class="test">hello</del> world</p>', output
  end

  test "#render with a tag and href attribute" do
    text = "<a href='test'>hello</a> world"
    output = Block.new.render("text" => text)
    assert_equal '<p><a href="test">hello</a> world</p>', output
  end

  test "#render with mark tag and class attribute" do
    text = "<mark class='test'>hello</mark> world"
    output = Block.new.render("text" => text)
    assert_equal '<p><mark class="test">hello</mark> world</p>', output
  end

  test "#render with code tag and class attribute" do
    text = "<code class='test'>hello</code> world"
    output = Block.new.render("text" => text)
    assert_equal '<p><code class="test">hello</code> world</p>', output
  end
end
