module Porygon
  module MessageBus
    class Message
      HANDLERS = {
        cycle_activity: Handler.new {
          Bot.cycle_activity
        },
        next_cycle_tiers: Handler.new(log: true) {
          Tiers.next_cycle
        },
        tick_tiers: Handler.new {
          Tiers.tick
        },
      }

      HANDLERS.default = NullHandler.new

      attr_reader :pid, :payload

      def initialize(pid, raw_payload)
        @pid = pid
        @payload = parse(raw_payload)
      end

      def handle
        HANDLERS[action].call(pid, action, payload)
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