# frozen_string_literal: true

module Porygon
  class BotClass
    module CheckAlive
      ASK  = 'ask_is_alive'
      TELL = 'tell_is_alive'

      TIMEOUT = 2.seconds

      def self.alive?
        return true if Bot.running_in_current_process?

        Database.notify(ASK)
        Database.listen(TELL, timeout: TIMEOUT)
      end

      extend ActiveSupport::Concern

      included do
        callback :respond_to_alive_checks, on: :connect
      end

      def running_in_current_process?
        !ENV['SKIP_BOT']
      end

      private

      def respond_to_alive_checks
        Thread.new { Database.listen(ASK, loop: true, &method(:handle)) }
      end

      def handle(*)
        Porygon::LOGGER.task('Got an alive check, responding with yes.')
        Database.notify(TELL)
      end
    end
  end
end