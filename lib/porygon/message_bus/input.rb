module Porygon
  module MessageBus 
    module Input
      class << self
        def cycle_activity
          notify :cycle_activity
        end

        def save_tiers
          notify :save_tiers
        end

        def tick_tiers
          notify :tick_tiers
        end

        private

        def notify(action, **payload)
          payload.reverse_merge!(action: action)
          Database.notify(CHANNEL, payload: payload.to_json)
        end
      end
    end
  end
end