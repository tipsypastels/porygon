module Discordrb
  module Events
    class MessageEvent
      def handle_message
        message.run_used_command
      end
    end
  end
end