module Arguments
  class Parser
    # An array-like structure that stores argument definitions.
    class DefinitionList
      include Enumerable

      attr_reader :args, :flags

      def initialize
        @args  = []
        @flags = []
      end

      def <<(defn)
        defn >> self
      end

      def each
        flags.each { yield _1 }
        args.each { yield _1 }
      end

      def validate!
        validate_string_count

        @args.each(&:validate!)
        @flags.each(&:validate!)
      end

      def usage(command)
        UsageBuilder.build(self, command)
      end

      private

      def validate_string_count
        if @args.count { |arg| arg.type.name == 'string' } > 1
          raise Commands::StaticError, 'parser.multiple_strings'
        end
      end
    end
  end
end