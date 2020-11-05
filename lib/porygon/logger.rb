module Porygon
  class Logger
    TIME_FORMAT = '%Y-%m-%d %H:%M:%S'

    MODES = {
      'UNKNOWN'   => :magenta,
      'INFO'      => :blue,
      'WARN'      => :yellow,
      'ERROR'     => :red,
      'FATAL'     => :black,
      'QUERY'     => :light_green,
      'RATELIMIT' => -> s { s.white.on_red },
    }

    MODES.each_key do |mode|
      define_method(mode.downcase) { |message| log(mode, message) }
    end

    def error(error)
      if error.is_a?(Exception)
        log('ERROR', error.inspect)
        error.backtrace.each { |line| error(line) }
      else
        log('ERROR', error)
      end
    end

    def log(mode, message)
      mode = mode.to_s.upcase
      time = Time.now.strftime(TIME_FORMAT)
      out  = "[#{mode} @ #{time}] #{message}"

      puts MODES[mode].to_proc.call(out)
    end
  end
end