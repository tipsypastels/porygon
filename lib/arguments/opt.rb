class Arguments
  class Opt
    delegate :slice, :convert, to: :@type

    def initialize(builder, long, type)
      @builder = builder
      @long    = long.to_s
      @short   = @long[0]
      @type    = Converter.for(self, type)
    end

    def eat(tokens, output, command)
      return unless (index = index_in(tokens))

      result = convert(tokens[index + 1], command)
      slice(tokens, index)

      output[@long] = result
    end

    def index_in(tokens)
      tokens.index("--#{@long}") || tokens.index("-#{@short}")
    end

    def usage
      usage = " -#{@short}, --#{@long}" + @type.usage
      usage += ", #{description}" if description
      usage
    end

    def missing_name
      "--#{@long}"
    end

    def description
      @description ||= t('description')
    end

    def t(key, **interps)
      @builder.t("#{@long}.#{key}", **interps)
    end
  end
end