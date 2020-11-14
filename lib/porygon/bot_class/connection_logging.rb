module Porygon
  class BotClass
    module ConnectionLogging
      extend ActiveSupport::Concern

      included do
        callback :log_connect,   on: :connect
        callback :log_reconnect, on: :reconnect
      end

      private

      def log_connect
        Porygon::LOGGER.info("We're ready to go!")
      end

      def log_reconnect
        Porygon::LOGGER.info('Reconnected!')
      end
    end
  end
end