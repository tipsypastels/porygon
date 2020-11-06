class Arguments
  class Arg
    delegate :convert, to: :@type

    def initialize(builder, name, type, default, optional)
      @builder  = builder
      @name     = name
      @type     = Converter.for(self, type)
      @default  = default
      @optional = optional
    end

    def eat(tokens, output, command)
      unless (rest = tokens.join(' ').presence)
        return output[@name] = default || missing
      end

      output[@name] = convert(rest, command)
      tokens.clear
    end

    def usage
      name_for_usage['['] ? name_for_usage : "[#{name_for_usage}]"
    end

    private

    def default
      @default.is_a?(Proc) ? @default.call : @default 
    end

    def missing
      unless @optional
        raise Commands::RuntimeError.new 'missing_arg', arg: @name
      end
    end

    def name_for_usage
      t('name', default: @name.to_s).downcase
    end

    def t(key, **interps)
      @builder.t("#{@name}.#{key}", **interps)
    end
  end
end