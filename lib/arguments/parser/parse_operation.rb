module Arguments
  class Parser
    # Represents a single operation by the parser for a use of a command.
    class ParseOperation
      attr_reader :parser, :command, :found, :tokens
      delegate :opts, :defs, to: :parser
      delegate :index, to: :tokens
      
      def initialize(parser, content, command)
        @parser   = parser
        @tokens   = content.split
        @command  = command
        @found    = {}
      end

      def parse
        consume_defs
        check_complete

        OutputArgs.new(found)
      end

      def flag_arg(idx, flag)
        tokens[idx + 1].presence || err(:missing_flag_arg, flag: flag)
      end

      def flag_index(flag)
        index("--#{flag.name}") || index("-#{flag.short_name}")
      end

      def missing(arg)
        err(:missing_arg, arg: arg)
      end
      
      def set(arg, value, delete_at = nil)
        @found[arg.name] = value
        delete(delete_at) if delete_at
      end

      private

      def consume_defs
        defs.each { _1.consume(self) }
      end
      
      def delete(idx)
        tokens.slice!(idx)
      end

      def clear
        @tokens = []
      end

      def err(key, **interps)
        raise Commands::UsageError.new key, **interps
      end

      def check_complete
        return if tokens.empty?

        err(:leftover_content)
      end
    end
  end
end