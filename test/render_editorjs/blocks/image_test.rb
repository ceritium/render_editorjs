# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::Blocks::ImageTest < Minitest::Test
  instance = RenderEditorjs::Blocks::Image.new

  valid_data = {
    "file" => {
      "url" => "/foo.png"
    },
    "caption" => "caption<br>",
    "withBorder" => false,
    "stretched" => false,
    "withBackground" => true
  }

  test "#render" do
    assert_equal '<div class="picture picture--with-background"><img src="/foo.png"></img></div><div class="caption">caption</div>', instance.render(valid_data)
  end
end
