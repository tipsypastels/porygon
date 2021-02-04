module Discordrb
  class Logger
    LOG_METHODS_TO_IGNORE    = %i[debug info good out in]
    LOG_METHODS_TO_PROPAGATE = %i[warn error ratelimit]

    LOG_METHODS_TO_IGNORE.each { |m| define_method(m) { |*| } }
    
    LOG_METHODS_TO_PROPAGATE.each do |method|
      define_method(method) { |message| Porygon::LOGGER.log(method, message) }
    end

    def log_exception(error)
      Porygon::LOGGER.log(:error, error)
    end
  end
end