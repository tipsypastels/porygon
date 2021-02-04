module Porygon
  class Logger
    DEFAULT_MODES = [
      Mode.new(:unknown, :magenta),
      Mode.new(:info, :blue),
      Mode.new(:error, :red),
      Mode.new(:warn, :yellow),
      Mode.new(:fatal, :black),
      Mode.new(:cache, -> s { s.black.on_cyan }),
      Mode.new(:ratelimit, -> s { s.white.on_red }),
      Mode.new(:task, -> s { s.black.on_green }),
    ]

    def initialize(modes = DEFAULT_MODES)
      @modes = modes.index_by(&:name)
      @modes.each_value(&method(:add_shortcut_method))
    end

    def log(mode_name, message)
      mode(mode_name).log(message)
    end

    def suppress(*mode_names)
      modes = mode_names.collect(&method(:mode))
      modes.each(&:suppress!)
      yield
    ensure
      modes.each(&:unsuppress!)
    end

    private

    def add_shortcut_method(mode)
      define_singleton_method(mode.name) { |msg| mode.log(msg) }
    end

    def mode(name)
      @modes.fetch(name)
    end
  end
end