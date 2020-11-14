module Porygon
  class OpStatsTracker
    class TimeSinceEventStat
      include ActionView::Helpers::DateHelper
      
      def time
        unless @time
          raise NotImplementedError, "Can't access time before starting the timer."
        end

        @time
      end

      def start_timing
        @time = Time.now
      end

      def ago_in_words
        distance_of_time_in_words(@time, Time.now)
      end
    end
  end
end