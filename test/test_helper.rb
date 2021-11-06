# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "/test/"
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "minitest/focus"

unless ENV["RM_INFO"]
  require "minitest/reporters"
  Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)
end

require "support/test_macro"
require "support/test_data"

require "render_editorjs"

Minitest::Test.class_eval do
  extend TestMacro
end
