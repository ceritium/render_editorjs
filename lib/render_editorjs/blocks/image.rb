# frozen_string_literal: true

module RenderEditorjs
  module Blocks
    # Render for  https://github.com/editor-js/image
    class Image < Base
      SCHEMA = YAML.safe_load(<<~YAML)
        type: object
        additionalProperties: false
        properties:
          file:
            type: object
            properties:
              url:
                type: string
            required:
            - url
          caption:
            type: string
          stretched:
            type: boolean
          withBackground:
            type: boolean
          withBorder:
            type: boolean
        required:
        - file
      YAML

      def render(data)
        return unless valid?(data)

        url = sanitize_url(data["file"]["url"])
        caption = sanitize_caption(data["caption"])
        with_border = data["withBorder"]
        with_background = data["withBackground"]
        stretched = data["stretched"]

        html_class = "picture"
        html_class += " picture--stretched" if stretched
        html_class += " picture--with-background" if with_background
        html_class += " picture--with-border" if with_border

        html_str = content_tag :div, class: html_class do
          content_tag :img, "", src: url
        end
        html_str << content_tag(:div, caption.html_safe, class: "caption").html_safe if caption.presence
        html_str
      end

      def sanitize(data)
        %w[caption url].each do |key|
          str = Sanitize.fragment(data[key], remove_contents: true).strip
          str.gsub!("&amp;", "&") if key == "url"
          data[key] = str
        end

        data
      end

      def sanitize_url(url)
        Sanitize.fragment(url, remove_contents: true).strip.gsub("&amp;", "&")
      end

      def sanitize_caption(caption)
        Sanitize.fragment(caption, remove_contents: true).strip
      end
    end
  end
end
