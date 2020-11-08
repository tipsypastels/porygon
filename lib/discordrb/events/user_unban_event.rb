module Discordrb
  module Events
    class UserUnbanEvent
      def handle_unban
        EventLogging.log_unban(server, user)
      end
    end
  end
end