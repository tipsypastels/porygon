module Discordrb
  module Events
    class UserBanEvent
      def handle_ban
        EventLogging.log_ban(server, user)
      end
    end
  end
end