module Porygon
  class OpStatsTracker
    attr_reader :start_time, :missing_deleted_messages

    delegate :start_timing, to: :start_time
    delegate :percent, to: :missing_deleted_messages, prefix: true

    def initialize
      @start_time = TimeSinceEventStat.new
      @missing_deleted_messages = FailurePercentStat.new
    end

    def join_cache_size
      MemberJoinList::MemberJoinDate.count
    end

    def message_cache_size
      Discordrb::Message.cache_size
    end
  end
end