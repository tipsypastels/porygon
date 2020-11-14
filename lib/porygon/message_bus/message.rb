module Porygon
  module MessageBus
    class Message
      HANDLERS = {
        cycle_activity: proc {
          Bot.cycle_activity
        },
      }

      MISSING = proc do
        Porygon::LOGGER.bus('No handler for that action was found.')
      end

      HANDLERS.default = MISSING

      attr_reader :pid, :payload

      def initialize(pid, raw_payload)
        @pid = pid
        @payload = parse(raw_payload)
      end

      def handle
        Porygon::LOGGER.bus("Received \"#{action}\" from process #{pid}")
        HANDLERS[action].call(payload)
      end

      private

      def action
        @action ||= payload['action']&.to_sym
      end

      def parse(raw)
        JSON.parse(raw)
      rescue
        {}
      end
    end
  end
end