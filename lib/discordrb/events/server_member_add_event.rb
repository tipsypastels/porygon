module Discordrb
  module Events
    class ServerMemberAddEvent
      def handle_join
        EventLogging.log_join(server, member)
      end
    end
  end
end