# RenderEditorjs

A modular and customizable Ruby renderer for [Editor.js](https://editorjs.io/).

This gem takes inspiration from [editor_js](https://github.com/xiaohui-zhangxh/editor_js).
It copies some code blocks logic and schema validations. The `editor_js` gem
implements the most common blocks. If you don't need any customization would make
sense give it a try.

In comparison, `RenderEditorjs` (this gem) only implement a few blocks, but you can
customize and extend it with your blocks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'render_editorjs'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install render_editorjs

## Usage

`RenderEditorjs` expects an Editor.js JSON as input; it can be a JSON serialized
as a string or a Hash.

### Basic usage

```ruby
RenderEditorjs.render(json) #=> HTML...
```

### Common usage

```ruby
renderer = RenderEditorjs::DefaultRenderer.new
document = RenderEditorjs::Document.new(json, renderer)

document.valid? #=> true | false
document.errors #=> Array with the schema errors
document.render #=> HTML...
```

### Advanced usage

Customize the DefaultRenderer adding or overriding blocks:

```ruby
renderer = RenderEditorjs::DefaultRenderer.new("header" => MyCustomHeader.new, "customBlock" => CustomBlock.new)
document = RenderEditorjs::Document.new(json, renderer)
document.render #=> My custom HTML
```

Create your renderer class:

```ruby
renderer = MyOwnRenderer.new
document = RenderEditorjs::Document.new(json, renderer)
document.render #=> My custom HTML
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ceritium/render_editorjs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ceritium/render_editorjs/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RenderEditorjs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ceritium/render_editorjs/blob/master/CODE_OF_CONDUCT.md).
