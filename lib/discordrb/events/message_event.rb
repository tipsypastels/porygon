module Discordrb
  module Events
    class MessageEvent
      def handle_message
        return unless message.server

        handle_command
        handle_caching
      end

      private
      
      def handle_command
        message.run_used_command
      end

      def handle_caching
        message.cache_in_db!
      end
    end
  end
end