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
    end
  end
end