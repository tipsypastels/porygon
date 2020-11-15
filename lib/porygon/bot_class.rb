module Porygon
  class BotClass
    include Callbacks
    include ConnectionLogging, CheckAlive

    include Activities, BotAccount, Ownership, Prefixed
    include MarkovCaching, MessageBusListening, MemberJoinLogging, StatTracking

    def initialize
      run_callbacks :init
    end

    private

    def ready
      if @connected_once
        run_callbacks :reconnect
      else
        @connected_once = true
        run_callbacks :connect
      end
    end
  end
end