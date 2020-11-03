module Porygon
  class EmbedBuilder < GenericHashBuilder
    hash_accessor :color, :title, :description
    wrapped_hash_accessor :thumbnail, inner_key: :url

    def initialize
      super
      @is_in_row = false
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