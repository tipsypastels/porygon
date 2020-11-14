module Porygon
  module MessageBus
    class Output
      def start_listening
        listen(CHANNEL, loop: true, &method(:handle))
      end

      private

      delegate :listen, to: :'Database::CONN'

      def handle(_channel, pid, raw_payload)
        Message.new(pid, raw_payload).handle
      end
    end
  end
end