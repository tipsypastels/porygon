module Porygon
  class GenericHashBuilder
    class << self
      # Like +attr_accessor+, but fetches and writes to the hash.
      # There are no reader/writer equivalents as hashbuilders
      # are meant to be fully mutable.
      def hash_accessor(*keys)
        keys.each do |key|
          define_method(key) { get(key) }
          define_method(:"#{key}=") { |val| set(key, val) }
        end
      end

      # Like +hash_accessor+, but wraps the value in an intermediate hash.
      # For example, Discord embed thumbnails are formatted as
      #
      #    { "thumbnail" => { "url" => value } }
      #
      # This abstraction allows us to ignore the inner hash and treat it
      # like a normal value while keeping the correct layout in the output hash.
      def wrapped_hash_accessor(key, inner_key:)
        define_method(key) { get(key, inner_key) }
        define_method(:"#{key}=") { |value| nest(key, inner_key, value) }
      end
    end

    def self.build(&block)
      new.build(&block)
    end
    
    def initialize
      @hash = {}.with_indifferent_access
    end

    def build
      yield self
      self
    end

    def to_h
      @hash
    end

    private

    def remove_nil_values?
      true
    end

    def get(*keys)
      @hash.dig(*keys)
    end

    def set(key, value, hash = @hash)
      if value.nil? && remove_nil_values?
        hash.delete(key)
      else
        hash[key] = value
      end
    end

    def nest(namespace, key, value)
      prefill(namespace, {})
      set(key, value, @hash[namespace])
    end

    def push(namespace, item)
      return unless permit?(item)

      prefill(namespace, [])
      @hash[namespace] << item
    end

    def prefill(namespace, empty_collection)
      @hash[namespace] ||= empty_collection
    end

    def permit?(value)
      !value.nil? || !remove_nil_values?
    end
  end
end