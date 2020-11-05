module Porygon
  module Loggers
    class BotLogger < Logger
      COLORS = {
        'UNKNOWN' => :magenta,
        'INFO'    => :blue,
        'WARN'    => :yellow,
        'ERROR'   => :red,
        'FATAL'   => :black,
      }

      def custom_formatter(severity, *)
        super.colorize COLORS.fetch(severity)
      end

      def error(err)
        case err
        when Exception
          super("(#{err.class}) #{err.message}\n#{err.backtrace.join("\n")}")
        else
          super
        end
      end
    end
  end
end