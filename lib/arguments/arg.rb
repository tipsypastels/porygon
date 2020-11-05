class Arguments
  class Arg
    delegate :convert, to: :@type

    def initialize(builder, name, type)
      @builder = builder
      @name    = name.to_s
      @type    = Converter.for(self, type)
    end

    def eat(tokens, output, command)
      return unless (rest = tokens.join(' ').presence)

      output[@name] = convert(rest, command)
      tokens.clear
    end

    def usage
      name_for_usage['['] ? name_for_usage : "[#{name_for_usage}]"
    end

    def missing_name
      @name
    end

    private

    def name_for_usage
      t('name', default: @name).downcase
    end

    def t(key, **interps)
      @builder.t("#{@name}.#{key}", **interps)
    end
  end
end