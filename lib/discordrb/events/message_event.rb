module Discordrb
  module Events
    class MessageEvent
      def handle
        message.run_used_command
      end
    end
  end
end