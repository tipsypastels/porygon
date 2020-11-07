class Arguments
  class Converter
    class << self
      protected :new

      def for(opt, type)
        type ? new(opt, type) : NullConverter.new
      end
    end

    def initialize(opt, type)
      @opt  = opt
      @type = type
    end

    def convert(value, command)
      @type.from_argument(method(:arg_error), value, command)      
    end

    def slice(tokens, index)
      tokens.slice!(index..(index + 1))
    end

    def usage
      @opt.t('name', default: @type.to_s.demodulize).upcase
    end

    private

    def arg_error(key, **interps)
      raise Commands::UsageError.new(
        "conversions.#{@type.name.underscore}.#{key}",
        **interps,
      )
    end

    class NullConverter
      def convert(*)
        true
      end

      def slice(tokens, index)
        tokens.slice!(index)
      end

      def usage
        nil
      end
    end
    private_constant :NullConverter
  end
end