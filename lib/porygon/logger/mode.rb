module Porygon
  class Logger
    class Mode
      TIME_FORMAT = '%Y-%m-%d %H:%M:%S'

      attr_reader :name, :color

      def initialize(name, color)
        @name  = name
        @color = color
        @suppressed = Porygon.thread_local(false)
      end

      def log(message)
        return if suppressed?
        return log_exception(message) if message.is_a?(Exception)

        out = "[#{label} @ #{time}] #{message}"
        puts color.to_proc.call(out)
      end

      def suppress!
        @suppressed.value = true
      end

      def unsuppress!
        @suppressed.value = false
      end

      private

      def label
        @label ||= name.to_s.upcase
      end

      def suppressed?
        @suppressed.value
      end

      def log_exception(exception)
        log(exception.message)
        exception.backtrace&.each { |line| log(line) }
      end

      def time
        Time.now.strftime(TIME_FORMAT)
      end
    end
  end
end