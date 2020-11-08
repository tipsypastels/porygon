module Commands
  class Command
    class Context
      attr_reader :ctx
      
      def initialize(ctx)
        @ctx = ctx
      end

      def allows?(command)
        @ctx != (command.server ? :dm : :server)
      end
    end
  end
end