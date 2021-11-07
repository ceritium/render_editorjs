# frozen_string_literal: true

require_relative "lib/render_editorjs/version"

Gem::Specification.new do |spec|
  spec.name          = "render_editorjs"
  spec.version       = RenderEditorjs::VERSION
  spec.authors       = ["José Galisteo"]
  spec.email         = ["ceritium@gmail.com"]

  spec.summary       = "A modular and customizable Ruby renderer for https://editorjs.io"
  spec.homepage      = "https://github.com/ceritium/render_editorjs"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ceritium/render_editorjs"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "actionview", ">= 4"
  spec.add_dependency "json-schema", "~> 2"
  spec.add_dependency "sanitize", "~> 6.0.0"
  spec.add_dependency "zeitwerk"
end
