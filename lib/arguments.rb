class Arguments
  delegate :arg, :opt, :optional, :usage, to: :@stack

  def initialize(command, **config)
    @command = command
    @config  = config
    @stack   = Stack.new(self)

    yield self
  end

  def parse(raw, command_instance)
    @stack.eat(tokenize(raw), command_instance)
  end

  def t(key, **opts)
    @command.t("_args.#{key}", **opts)
  end

  private

  def tokenize(raw)
    case @config[:split]
    when :never  then [raw]
    when :spaces then raw.split
    else              raw.shellsplit
    end
  end
end