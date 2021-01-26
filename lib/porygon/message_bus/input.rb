module Porygon
  module MessageBus 
    module Input
      class << self
        MACROS = %i[
          cycle_activity
          tick_tiers
          next_cycle_tiers
        ]

        MACROS.each do |macro|
          define_method macro do
            notify macro
          end
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