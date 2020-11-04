module Porygon
  module Internals
    class Logger < ::Logger
      COLORS = {
        'UNKNOWN' => :magenta,
        'INFO'    => :blue,
        'WARN'    => :yellow,
        'ERROR'   => :red,
        'FATAL'   => :black,
      }

      def initialize
        super(STDOUT)

        self.formatter = proc do |severity, time, _, msg|
          color = COLORS.fetch(severity)
          timestr = time.strftime('%Y-%m-%d %H:%M:%S')

          "[#{severity} @ #{timestr}] #{msg}".colorize(color)
        end
      end

      def error(error)
        case error
        when Exception
          super(error.message + "\n" + error.backtrace.join("\n"))
        else
          super
        end
      end
    end
  end
end