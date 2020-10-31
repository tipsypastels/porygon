module Arguments
  class Parser
    # Represents a single operation by the parser for a use of a command.
    class ParseOperation
      attr_reader :parser, :content, :command, :found, :tokens
      delegate :opts, :defs, to: :parser
      
      def initialize(parser, content, command)
        @parser   = parser
        @content  = content.dup
        @tokens   = content.split
        @command  = command
        @found    = {}
      end

      def parse
        parse_flags
        parse_args
        
        check_complete

        OutputArgs.new(found)
      end

      
      private
      
      def set(key, value)
        @found[key] = value
      end

      def delete(idx)
        @tokens.slice!(idx)
        @content = @tokens.join(' ')
      end

      def clear
        @tokens  = []
        @content = ''
      end

      def err(key, **interps)
        raise Commands::UsageError.new key, **interps
      end

      def convert(value, type)
        type.call(value, command)
      end

      def parse_flags
        defs.flags.each(&method(:consume_flag))
      end

      def parse_args
        defs.args.each(&method(:consume_arg))
      end
      
      # rubocop:disable Metrics/MethodLength
      def consume_flag(flag)
        idx = flag.index_in(tokens)
        return handle_missing_flag(flag) unless idx

        if flag.needs_arg?
          arg = tokens[idx + 1]
          return err(:missing_flag_arg, flag: flag) unless arg.present?

          value = convert(arg, flag.type)

          set(flag.name, value)
          delete(idx..(idx + 1))
        else
          set(flag.name, true)
          delete(idx)
        end
      end
      # rubocop:enable Metrics/MethodLength

      def handle_missing_flag(flag)
        return if flag.optional?
        return set(flag.name, flag.default) if flag.default

        err(:missing_flag, flag: flag)
      end

      def consume_arg(arg)
        return handle_missing_arg(arg) if content.blank?

        if defs.args.length == 1
          value = convert(content, arg.type)

          set(arg.name, value)
          clear
        else
          # TODO: support multiple args
          raise 'Multiple args is not supported yet.'
        end
      end

      def handle_missing_arg(arg)
        return if arg.optional?
        return set(arg.name, arg.default) if arg.default

        err(:missing_arg, arg: arg)
      end

      def check_complete
        return if tokens.empty?

        err(:leftover_content)
      end
    end
  end
end