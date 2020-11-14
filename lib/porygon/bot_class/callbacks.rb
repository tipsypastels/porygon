module Porygon
  class BotClass
    module Callbacks
      extend ActiveSupport::Concern

      class_methods do
        def callback(callback, on:)
          Array(on).each { |event| callbacks[event] << callback }
        end

        def callbacks
          @callbacks ||= Hash.new { |h, k| h[k] = [] }
        end
      end

      included do
        delegate :callbacks, to: :class
      end

      def run_callbacks(event)
        callbacks[event].each(&method(:send))
      end
    end
  end
end