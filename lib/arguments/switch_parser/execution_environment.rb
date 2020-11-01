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

      def format(name, **opts, &block)
        @formats[name] = Parser.new(**opts, &block)
      end

      def default(**opts, &block)
        if block
          format(DEFAULT, **opts, &block)
        else
          @formats[DEFAULT] = Parser.new(**opts)
        end
      end
    end
  end
end