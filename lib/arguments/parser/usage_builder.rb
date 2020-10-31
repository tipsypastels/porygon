module Arguments
  class Parser
    class UsageBuilder
      def self.build(defs, command)
        new(defs, command).build
      end

      attr_reader :defs, :command

      def initialize(defs, command)
        @defs    = defs
        @command = command
      end

      def build
        entries = defs.args.map { |arg| arg.to_usage(command) } \
                + defs.flags.map { |flag| flag.to_usage(command) }
        
        entries.join(' ')
      end
    end
  end
end