# frozen_string_literal: true

module Porygon
  class BotClass
    module CheckAlive
      ASK  = 'ask_is_alive'
      TELL = 'tell_is_alive'

      TIMEOUT = 2.seconds

      def self.alive?
        Database::CONN.notify(ASK)
        Database::CONN.listen(TELL, timeout: TIMEOUT)
      end

      extend ActiveSupport::Concern

      included do
        callback :respond_to_alive_checks, on: :connect
      end

      private

      delegate :listen, :notify, to: :'Database::CONN'

      def respond_to_alive_checks
        Thread.new { listen(ASK, loop: true, &method(:handle)) }
      end

      def handle(*)
        Porygon::LOGGER.bus('Got an alive check, responding with yes.')
        notify(TELL)
      end
    end
  end
end