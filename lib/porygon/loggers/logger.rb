module Porygon
  module Loggers
    class Logger < ::Logger
      def initialize
        super STDOUT

        self.formatter = method(:custom_formatter)
      end

      def custom_formatter(severity, time, _, message)
        timestr = time.strftime('%Y-%m-%d %H:%M:%S')
        "[#{severity} @ #{timestr}] #{message}\n" 
      end
    end
  end
end