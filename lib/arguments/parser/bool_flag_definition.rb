module Arguments
  class Parser
    # A bool flag implies +true+ by its presence, it does not take an arg.
    class BoolFlagDefinition < GenericFlagDefinition
      def initialize(name, **opts)
        @name = name
        @opts = opts
      end

      def validate!
        validate_optional_type
        validate_multiple_type
      end

      def to_usage(_command)
        wrap_for_usage("--#{name}")
      end

      def wrap_for_usage(string)
        "[#{string}]"
      end

      private
      
      def validate_optional_type
        unless optional?
          raise Commands::StaticError, 'parser.bool_flags_must_be_optional'
        end
      end

      def validate_multiple_type
        if multiple?
          raise Commands::StaticError, 'parser.bool_flags_may_not_be_multiple'
        end
      end
    end
  end
end