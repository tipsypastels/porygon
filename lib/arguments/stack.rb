class Arguments
  class Stack
    delegate :t, to: :@builder

    def initialize(builder)
      @arg  = nil
      @opts = []
      @map  = {}

      @builder  = builder
      @required = []
      @defaults = {}
    end

    def opt(name, type = nil, default: nil, optional: false)
      set_required_default(name, optional, default)

      opt = Opt.new(@builder, name, type)

      @map[name] = opt
      @opts << opt
    end

    def arg(name, type, default: nil, optional: false)
      check_multi_arg
      set_required_default(name, optional, default)

      @arg = Arg.new(@builder, name, type)
      @map[name] = @arg
    end

    def each
      @opts.each { |opt| yield opt }
      yield @arg if @arg
    end

    def each_default
      @defaults.each { |opt, value| yield opt, value }
    end

    def usage
      @usage ||= [@arg, *@opts].collect(&:usage).join("\n")
    end

    def first_missing(output_hash)
      missing = @required.detect { |opt| !output_hash.key?(opt) }
      @map[missing].missing_name if missing
    end

    private

    def set_required_default(name, optional, default)
      @required << name unless optional || default
      @defaults[name] = default if default
    end

    def check_multi_arg
      raise Commands::StaticError, 'multiple_args_unsupported' if @arg
    end
  end
end