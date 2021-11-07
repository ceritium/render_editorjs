# frozen_string_literal: true

module TestData
  VALID_WITHOUT_BLOCK = {
    "time" => 1,
    "blocks" => [],
    "version" => "1.0"
  }.freeze

  VALID_BLOCK = {
    "type" => "paragraph",
    "data" => {
      "text" => "hello world"
    }
  }.freeze

  INVALID_BLOCK = {
    "type" => "paragraph",
    "data" => { "foo" => "bar" }
  }.freeze

  VALID_WITH_BLOCK = {
    "time" => 1,
    "blocks" => [VALID_BLOCK],
    "version" => "1.0"
  }.freeze

  WITH_VALID_AND_INVALID_BLOCKS = {
    "time" => 1,
    "blocks" => [VALID_BLOCK, INVALID_BLOCK],
    "version" => "1.0"
  }.freeze

  EMPTY = {}.freeze
end
