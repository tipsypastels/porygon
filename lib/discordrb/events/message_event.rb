module Discordrb
  module Events
    class MessageEvent
      def handle_message
        return unless message.server

        handle_command
        handle_caching
        handle_points
      end

      private
      
      def handle_command
        message.run_used_command
      end

      def handle_caching
        message.cache_in_db!
      end

      def handle_points
        Porygon::Tiers.handle(message)
      end
    end
  end
end