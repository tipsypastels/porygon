module Discordrb
  module Events
    class MessageDeleteEvent
      def handle_delete
        EventLogging.log_delete(channel, id)
      end
    end
  end
end