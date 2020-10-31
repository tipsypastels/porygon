module Discordrb
  module Events
    class MessageEvent
      def handle
        handle_command
      end

      private

      def handle_command
        command = message.command
        command.begin_call if command
      end
    end
  end
end