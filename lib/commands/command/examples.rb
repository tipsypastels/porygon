module Commands
  class Command
    class Examples
      include Porygon::MessageFormatter

      class << self
        protected :new

        def build(command, tag)
          new(command, tag).build
        end
      end

      def initialize(command, tag)
        @command  = command
        @tag      = tag
        @examples = Array(command.t('_examples', default: nil))
      end

      def build
        @build ||=
          if prefixed.present?
            code_block(prefixed.join("\n"))
          end
      end

      private

      def prefixed
        @prefixed ||= @examples.map { |e| "#{prefix} #{e}" }
      end

      def prefix
        Bot.prefix + @tag
      end
    end
  end
end