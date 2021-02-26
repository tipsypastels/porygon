module Porygon
  class BotClass
    module Activities
      extend ActiveSupport::Concern
      
      included do
        callback :cycle_activity, on: %i[connect reconnect]
      end

      def activity=(activity)
        @bot.playing = activity
      end

      def cycle_activity
        self.activity = Porygon::ActivityMessage.sample
      end
    end
  end
end