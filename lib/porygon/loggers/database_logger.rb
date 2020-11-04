module Porygon
  module Loggers
    class DatabaseLogger < Logger
      COLOR = :light_green
      
      def custom_formatter(_, time, _, message)
        timestr = time.strftime('%Y-%m-%d %H:%M:%S')
        "[SQL @ #{timestr}] #{message}\n".colorize(COLOR) 
      end
    end
  end
end