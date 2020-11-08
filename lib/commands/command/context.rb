module Commands
  class Command
    class Context
      attr_reader :ctx
      
      def initialize(ctx)
        @ctx = ctx
      end

      def allows?(command)
        case ctx
        when :dm     then !command.server
        when :server then command.server
        when :any    then true
        else raise ArgumentError, "Invalid command context: #{ctx}"
        end
      end
    end
  end
end