module Commands
  class Command
    class Usage
      include Porygon::MessageFormatter

      class << self
        protected :new

        def build(command, tag)
          new(command, tag).build
        end
      end

      def initialize(command, tag)
        @command = command
        @tag     = tag
      end

      def build
        @build ||= code_block(build_usage)
      end
      
      private
      
      def build_usage
        if @command.args
          usage_with_args
        else
          prefix
        end
      end

      def usage_with_args
        prefix + @command.args.usage
      end

      def prefix
        Bot.prefix + @tag
      end
    end
  end
end