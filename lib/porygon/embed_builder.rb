module Porygon
  class EmbedBuilder < GenericHashBuilder
    hash_accessor :color, :title, :description
    wrapped_hash_accessor :thumbnail, inner_key: :url
    wrapped_hash_accessor :footer, inner_key: :text

    def initialize
      super
      @is_in_row = false
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