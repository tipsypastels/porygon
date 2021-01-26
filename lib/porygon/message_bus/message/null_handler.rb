module Porygon
  module MessageBus
    class Message
      class NullHandler
        def call(_pid, action, _payload)
          Porygon::LOGGER.task("Received unknown action: #{action}.")
        end
      end
    end
  end
end