module Porygon
  class OpStatsTracker
    attr_reader :missing_deleted_messages

    delegate :percent, to: :missing_deleted_messages, prefix: true

    def initialize
      @missing_deleted_messages = FailurePercentage.new
    end

    class FailurePercentage
      attr_reader :total, :fails

      def initialize
        @total = 0
        @fails = 0
      end

      def percent
        return 0 if @total.zero?

        ((fails.to_f / total) * 100).to_i
      end

      def pass!
        @total += 1
      end

      def fail!
        @total += 1
        @fails += 1
      end
    end
  end
end