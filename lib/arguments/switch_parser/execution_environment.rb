module Arguments
  class SwitchParser
    # A disposable container for executing the block given to +SwitchParser+'s
    # initializer, and constructing the argument formats based on that.
    class ExecutionEnvironment
      DEFAULT = ResultWrapperWithDynamicMethod::DEFAULT

      def self.call(&block)
        new(&block).result
      end

      def initialize
        @formats = FormatList.new
        yield self
      end

      def result
        @formats
      end

      def format(name, &block)
        @formats[name] = Parser.new(&block)
      end

      def default(&block)
        if block
          format(DEFAULT, &block)
        else
          @formats[DEFAULT] = Parser.new
        end
      end
    end
  end
end