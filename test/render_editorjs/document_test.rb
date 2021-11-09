# frozen_string_literal: true

require "test_helper"

class RenderEditorjs::DocumentTest < Minitest::Test
  test "use default renderer as default" do
    document = RenderEditorjs::Document.new(TestData::EMPTY)
    assert_kind_of RenderEditorjs::DefaultRenderer, document.renderer
  end

  test "with invalid json return empty string" do
    document = RenderEditorjs::Document.new("it is not a json")
    assert_equal "", document.render
    refute document.valid?
    assert document.errors.present?
  end

  test "the schema for renderer is invalid return empty string" do
    document = RenderEditorjs::Document.new(TestData::EMPTY)
    assert_equal "", document.render
    refute document.valid?
    assert document.errors.present?
  end

  test "valid schema without blocks" do
    document = RenderEditorjs::Document.new(TestData::VALID_WITHOUT_BLOCK)
    assert_equal "", document.render
    assert document.valid?
    assert document.errors.blank?
  end

  test "valid schema with block" do
    document = RenderEditorjs::Document.new(TestData::VALID_WITH_BLOCK)
    assert_equal "<p>hello world</p>", document.render
    assert document.valid?
    assert document.errors.blank?
  end

  test "with invalid block" do
    document = RenderEditorjs::Document.new(TestData::INVALID_BLOCK)
    assert_equal "", document.render
    refute document.valid?
    assert document.errors.present?
  end

  test "with valid and invalid blocks" do
    document = RenderEditorjs::Document.new(TestData::WITH_VALID_AND_INVALID_BLOCKS)
    assert_equal "<p>hello world</p>", document.render
    refute document.valid?
    assert document.errors.present?
  end
end
