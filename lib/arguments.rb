class Arguments
  def initialize(command, **opts)
    @op       = Parser.new(command)
    @command  = command
    @required = []
    @defaults = {}
    @opts     = opts

    yield self

    precache_usage
  end

  def parse(raw_args, _command_instance)
    internal_parse(split_tokens(raw_args), @opts[:output]&.dup || {})
  end

  def arg(name, type, optional: false, default: nil)
    raise Commands::StaticError, 'multiple_args_unsupported' if @arg

    @defaults[name] = default if default
    @required << name unless optional || default
    @op.banner += " [#{arg_value_name(name)}]"

    @arg = { 
      name: name, 
      switch: @op.define('--INTERNAL_DEFARG ARG', type),
    }
  end

  def opt(long, type = nil, short: nil, optional: false, default: nil)
    @required << long unless optional || default
    @defaults[long] = default if default

    long = long.to_s
    short ||= long[0]

    desc = t("#{long}.description", default: '')
    value = opt_value_name(long, type)

    @op.opt(short, long, value, type, desc)
  end

  def usage
    @usage ||= @op.help.split("\n").reject { _1['INTERNAL'] }.join("\n")
  end
  
  alias precache_usage usage

  def t(key, **opts)
    @command.t("_args.#{key}", **opts)
  end

  private

  def internal_parse(tokens, output)
    @op.parse!(tokens, into: output)
    
    merge_positional_arg(tokens, output)
    merge_defaults(output)
    check_required(output)

    Result.new(output)
  end

  def merge_positional_arg(tokens, output)
    return unless @arg && tokens.present?

    @op.parse!(['--INTERNAL_DEFARG', tokens.join(' ')], into: output)
    output[@arg[:name]] = output.delete(:INTERNAL_DEFARG)
  end

  def merge_defaults(output)
    @defaults.each { |opt, value| output[opt] ||= resolve_default(value) }
  end

  def check_required(output)
    missing = @required.detect { |opt| !output.key?(opt) }

    if missing
      raise Commands::RuntimeError.new 'missing_arg', 
                                       arg: arg_value_name(missing)
    end
  end

  def split_tokens(raw_args)
    case @opts[:split]
    when :spaces then raw_args.split
    else              raw_args.shellsplit
    end
  end

  def opt_value_name(long, type)
    return unless type
    t("#{long}.name", default: type.to_s.demodulize).upcase
  end

  def arg_value_name(name)
    t("#{name}.name", default: name.to_s).downcase
  end

  def resolve_default(value)
    value.is_a?(Proc) ? value.call : value
  end
end