module Porygon
  module MessageBus 
    module Input
      class << self
        def cycle_activity
          notify :cycle_activity
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