module Porygon
  class EmbedBuilder
    def self.build(&block)
      new.build(&block)
    end

    def initialize
      @hash        = {}.with_indifferent_access
      @is_inline   = false
      @attachments = []
    end

    def build
      yield self
      self
    end

    def to_h
      @hash
    end

    def attachments
      @attachments.presence
    end

    ELEMENTARY_GETTERS = %i[title color description footer author thumbnail]
    ELEMENTARY_SETTERS = %i[title color description]

    ELEMENTARY_GETTERS.each do |prop|
      define_method(prop) { @hash[prop] }
    end
    
    ELEMENTARY_SETTERS.each do |prop|
      define_method(:"#{prop}=") do |val| 
        converted_val = convert(val)
        @hash[prop] = converted_val if converted_val
      end
    end

    def footer=(value)
      case value
      when NilClass
        # pass
      when Hash
        @hash[:footer] = value
      else
        @hash[:footer] = { text: convert(value) }
      end
    end

    def author=(value)
      case value
      when NilClass
        # pass
      when Hash
        @hash[:author] = value
      else
        @hash[:author] = { name: convert(value) }
      end
    end

    def thumbnail=(value)
      case value
      when NilClass
        # pass
      when Hash
        @hash[:thumbnail] = value
      when Porygon::Asset
        @attachments << value.file
        @hash[:thumbnail] = { url: value.attachment_path }
      when String
        @hash[:thumbnail] = { url: convert(value) }
      end
    end

    def field(name, value, inline: @is_inline)
      return if value.blank?
      push :fields, name: name, value: value, inline: inline
    end

    def inline
      @is_inline = true
      yield
    ensure
      @is_inline = false
    end

    private

    def convert(value)
      if value.respond_to?(:to_discord_embed)
        value.to_discord_embed
      else
        value.to_s
      end
    end

    def push(key, value)
      @hash[key] ||= []
      @hash[key] << value
    end
  end
end