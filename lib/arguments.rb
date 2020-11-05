class Arguments
  delegate :arg, :opt, :usage, to: :@stack

  def initialize(command, **config)
    @command = command
    @config  = config
    @stack   = Stack.new(self)

    yield self
  end

  def parse(raw, command_instance)
    Parser.parse(tokenize(raw), command_instance, @stack)
  end

  def t(key, **opts)
    @command.t("_args.#{key}", **opts)
  end

  private

  def tokenize(raw)
    case @config[:split]
    when :spaces then raw.split
    else              raw.shellsplit
    end
  end
end