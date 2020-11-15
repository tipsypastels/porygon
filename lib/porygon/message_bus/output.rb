module Porygon
  module MessageBus
    class Output
      attr_reader :received

      def initialize
        @received = 0
      end

      def start_listening
        Thread.new { listen(CHANNEL, loop: true, &method(:handle)) }
      end

      private

      delegate :listen, to: :'Database::CONN'

      def handle(_channel, pid, raw_payload)
        @received += 1
        
        Message.new(pid, raw_payload).handle
      end
    end
  end
end