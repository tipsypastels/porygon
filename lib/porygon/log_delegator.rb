module Porygon
  class LogDelegator
    def initialize(force_mode)
      @force_mode = force_mode
    end

    def info(message)
      Porygon::LOGGER.log(@force_mode, message)
    end

    alias warn info
    alias error info
  end
end