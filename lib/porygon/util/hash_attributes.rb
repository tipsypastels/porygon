module Porygon
  module Util
    module HashAttributes
      def hash_attr_reader(*keys, on:)
        keys.each do |key|
          module_eval <<~RUBY, __FILE__, __LINE__ + 1
            def #{key}
              #{on}[:#{key}]
            end
          RUBY
        end
      end

      def hash_attr_writer(*keys, on:)
        keys.each do |key|
          module_eval <<~RUBY, __FILE__, __LINE__ + 1
            def #{key}=(value)
              #{on}[:#{key}] = value
            end
          RUBY
        end
      end

      def hash_attr_accessor(...)
        hash_attr_reader(...)
        hash_attr_writer(...)
      end
    end
  end
end