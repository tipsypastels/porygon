module Commands
  class Command
    class Examples
      include Porygon::MessageFormatter

      delegate :tag, to: :@command

      class << self
        protected :new

        def build(command)
          new(command).build
        end
      end

      def initialize(command)
        @command  = command
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
        @prefixed ||= @examples.map { |e| "#{Bot.prefix}#{tag} #{e}" }
      end
    end
  end
end