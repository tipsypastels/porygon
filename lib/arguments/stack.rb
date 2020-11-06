class Arguments
  class Stack
    delegate :t, to: :@builder

    def initialize(builder)
      @arg  = nil
      @opts = []
      @map  = {}

      @in_optional = false
      @builder     = builder
    end

    def opt(name, type = nil, default: nil, optional: @in_optional)
      @opts << Opt.new(@builder, name, type, default, optional)
    end

    def arg(name, type, default: nil, optional: @in_optional)
      check_multi_arg
      @arg = Arg.new(@builder, name, type, default, optional)
    end

    def optional
      @in_optional = true
      yield
    ensure
      @in_optional = false
    end

    def eat(tokens, command)
      output = {}
      each { |opt| opt.eat(tokens, output, command) }
      output
    end

    def usage
      @usage ||= [@arg, *@opts].compact.collect(&:usage).join("\n")
    end

    private

    def check_multi_arg
      raise Commands::StaticError, 'multiple_args_unsupported' if @arg
    end

    def each
      @opts.each { |opt| yield opt }
      yield @arg if @arg
    end
  end
end