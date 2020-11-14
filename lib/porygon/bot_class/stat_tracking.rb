module Porygon
  class BotClass
    module StatTracking
      extend ActiveSupport::Concern

      included do
        attr_reader :stats
        delegate :start_timing, to: :stats

        callback :init_stats,   on: :init
        callback :start_timing, on: :connect
      end

      private

      def init_stats
        @stats = OpStatsTracker.new
      end
    end
  end
end