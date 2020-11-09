module Discordrb
  module Events
    class ServerRoleDeleteEvent
      def handle_delete
        Role::RequestableRole.garbage_collect(self)
      end
    end
  end
end