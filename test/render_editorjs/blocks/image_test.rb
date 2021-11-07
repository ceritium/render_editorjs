# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::Blocks::ImageTest < Minitest::Test
  instance = RenderEditorjs::Blocks::Image.new
  valid_data = {
    "file" => {
      "url" => "/foo.png"
    }
  }

  test "#render invalid data" do
    assert_nil instance.render({})
  end

  test "#render with valid data" do
    expected_html = '<div class="picture"><img src="/foo.png"></img></div>'
    assert_equal expected_html, instance.render(valid_data)
  end

  test "#render with caption" do
    expected_html = '<div class="picture"><img src="/foo.png"></img></div><div class="caption">bar</div>'
    assert_equal expected_html, instance.render(valid_data.merge("caption" => "bar"))
  end

  test "#render with border" do
    expected_html = '<div class="picture picture--with-border"><img src="/foo.png"></img></div>'
    assert_equal expected_html, instance.render(valid_data.merge("withBorder" => true))
  end

  test "#render with background" do
    expected_html = '<div class="picture picture--with-background"><img src="/foo.png"></img></div>'
    assert_equal expected_html, instance.render(valid_data.merge("withBackground" => true))
  end

  test "#render stretched" do
    expected_html = '<div class="picture picture--stretched"><img src="/foo.png"></img></div>'
    assert_equal expected_html, instance.render(valid_data.merge("stretched" => true))
  end
end
