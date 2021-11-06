# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "minitest/focus"

unless ENV['RM_INFO']
  require "minitest/reporters"
  Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)
end

require "support/test_macro"

require "render_editorjs"

Minitest::Test.class_eval do
  extend TestMacro
end
