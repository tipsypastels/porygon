module Porygon
  module MessageBus
    class Message
      class Handler
        def initialize(log: false, &block)
          @log = log
          @block = block
        end

        def call(pid, action, payload)
          log(pid, action) if @log

          @block.call(payload)
        end

        private

        def log(pid, action)
          Porygon::LOGGER.task("Received \"#{action}\" from process #{pid}")
        end
      end
    end
  end
end