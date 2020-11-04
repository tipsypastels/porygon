module Porygon
  class EmbedBuilder < GenericHashBuilder
    hash_accessor :color, :title, :description

    def initialize
      super
      @is_in_row = false
      @attachments = []
    end

    def attachments
      @attachments.presence
    end

    def footer
      get('footer')
    end

    def footer=(value)
      case value
      when String
        nest('footer', 'text', value)
      else
        set('footer',  value)
      end
    end

    def author=(value)
      case value
      when String
        nest('author', 'name', value)
      else
        set('author', value)
      end
    end

    def thumbnail
      get('thumbnail')
    end

    def thumbnail=(value)
      case value
      when String
        nest('thumbnail', 'url', value)
      when Hash
        set('thumbnail', value)
      when Porygon::Asset
        @attachments << value.file
        nest('thumbnail', 'url', value.attachment_path)
      end
    end

    def field(name, value, inline: @is_in_row)
      return if value.blank?
      push :fields, name: name, value: value, inline: inline
    end

    def field_row
      @is_in_row = true
      yield
    ensure
      @is_in_row = false
    end
  end
end