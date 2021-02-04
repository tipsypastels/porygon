module Porygon
  class Logger
    class SuppressList < Concurrent::ThreadLocalVar
      def initialize
        super(Set.new)
      end

      def suppress(modes)
        value.merge(modes)
        yield
      ensure
        value.clear
      end

      def include?(mode)
        value.include?(mode)
      end
    end
  end
end