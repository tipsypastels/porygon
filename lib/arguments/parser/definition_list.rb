module Arguments
  class Parser
    # An array-like structure that stores argument definitions.
    class DefinitionList
      attr_reader :args, :flags

      def initialize
        @args  = []
        @flags = []
      end

      def <<(defn)
        category(defn) << defn
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
        if @args.count { |arg| arg.type == :string } > 1
          raise Commands::StaticError, 'parser.multiple_strings'
        end
      end

      def category(defn)
        defn.is_a?(GenericFlagDefinition) ? @flags : @args
      end
    end
  end
end