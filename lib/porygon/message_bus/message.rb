module Porygon
  module MessageBus
    class Message
      HANDLERS = {
        cycle_activity: proc {
          Bot.cycle_activity
        },
        save_tiers: proc {
          Tiers.save
        },
        tick_tiers: proc {
          Tiers.tick
        },
      }

      HANDLERS.default_proc = proc do |_, action|
        proc do
          Porygon::LOGGER.task("Received unknown action: #{action}.")
        end
      end

      attr_reader :pid, :payload

      def initialize(pid, raw_payload)
        @pid = pid
        @payload = parse(raw_payload)
      end

      def handle
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