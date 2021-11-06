# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::Blocks::NestedListTest < Minitest::Test
  instance = RenderEditorjs::Blocks::List.new

  ordered_list = {
    "style" => "ordered",
    "items" => [
      {
        "content" => "simple"
      },
      {
        "content" => "list"
      }
    ]
  }

  unordered_list = {
    "style" => "unordered",
    "items" => [
      {
        "content" => "simple"
      },
      {
        "content" => "list"
      }
    ]
  }

  nested_list = {
    "style" => "unordered",
    "items" => [
      {
        "content" => "A",
        "items" => [
          {
            "content" => "B",
            "items" => [
              "content" => "C"
            ]
          }
        ]
      }
    ]
  }

  test "#render" do
    assert_equal "<ol><li>simple</li><li>list</li></ol>", instance.render(ordered_list)
    assert_equal "<ul><li>simple</li><li>list</li></ul>", instance.render(unordered_list)
    assert_equal "<ul><li>A<ul><li>B<ul><li>C</li></ul></li></ul></li></ul>", instance.render(nested_list)
  end
end
