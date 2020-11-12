class Arguments
  class Opt
    delegate :slice, :convert, to: :@type

    def initialize(builder, long, type, default, optional)
      @builder  = builder
      @long     = long
      @short    = long[0]
      @type     = Converter.for(self, type)
      @default  = default
      @optional = optional
    end

    def name_in_output
      @long
    end

    def eat(tokens, output, command)
      unless (index = index_in(tokens))
        return output[@long] = default(command) || missing
      end

      result = convert(tokens[index + 1], command)
      slice(tokens, index)

      output[@long] = result
    end

    def index_in(tokens)
      tokens.index("--#{@long}") || tokens.index("-#{@short}")
    end

    def usage
      usage = " -#{@short}, --#{@long}"
      usage += " #{@type.usage}"  if @type.usage
      usage += ", #{desc}" if desc
      usage
    end

    def missing_name
      "--#{@long}"
    end

    def desc
      @desc ||= t('desc', default: nil)
    end

    def t(key, **interps)
      @builder.t("#{@long}.#{key}", **interps)
    end

    private

    def default(command)
      @default.is_a?(Proc) ? @default.call(command) : @default 
    end

    def missing
      unless @optional
        raise Commands::UsageError.new 'missing_arg', arg: @long
      end
    end
  end
end