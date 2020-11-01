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
        validate_greedy_count
        push_greedy_args_to_end

        @args.each(&:validate!)
        @flags.each(&:validate!)
      end

      def usage(command)
        UsageBuilder.build(self, command)
      end

      private

      def validate_greedy_count
        if @args.count { |arg| arg.type.is_a?(Resolvers::GreedyResolver) } > 1
          raise Commands::StaticError, 'parser.multiple_greedy_resolvers'
        end
      end

      def push_greedy_args_to_end
        @args.sort! do |a, b|
          next  1 if a.consume_last? && !b.consume_last?
          next -1 if b.consume_last? && !a.consume_last?
          0
        end
      end
    end
  end
end