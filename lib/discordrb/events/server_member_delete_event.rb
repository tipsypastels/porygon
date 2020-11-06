module Discordrb
  module Events
    class ServerMemberDeleteEvent
      def handle_leave
        EventLogging.log_leave(server, user)
      end
    end
  end
end