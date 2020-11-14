module Porygon
  class BotClass
    module Activities
      extend ActiveSupport::Concern
      
      ACTIVITIES = I18n.t('bot_activities')

      included do
        callback :cycle_activity, on: %i[connect reconnect]
      end

      def activity=(activity)
        @bot.playing = activity
      end

      def cycle_activity
        self.activity = ACTIVITIES.sample
      end
    end
  end
end