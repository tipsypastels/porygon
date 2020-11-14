module Porygon
  class BotClass
    module MessageBusListening
      extend ActiveSupport::Concern

      included do
        attr_reader :message_bus

        callback :init_bus,   on: :init
        callback :listen_bus, on: :connect
      end

      private

      def init_bus
        @message_bus = MessageBus::Output.new
      end

      def listen_bus
        @message_bus.start_listening
      end
    end
  end
end