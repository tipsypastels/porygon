module Discordrb
  module Events
    class ChannelDeleteEvent
      def handle_delete
        Packages::Package::EnabledPackage.garbage_collect(self)
      end
    end
  end
end