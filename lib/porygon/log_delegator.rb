module Porygon
  class LogDelegator
    class << self
      attr_accessor :enabled
    end

    def initialize(force_mode)
      @force_mode = force_mode
    end

    def info(message)
      return unless self.class.enabled
      Porygon::LOGGER.log(@force_mode, message)
    end

    alias warn info
    alias error info
  end
end