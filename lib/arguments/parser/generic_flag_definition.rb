module Arguments
  class Parser
    # A flag is a variant on an arg that's used by name. This class provides
    # a generic interface extended by two sub-types of flags.
    class GenericFlagDefinition < ArgDefinition
      def validate!
        # no-op
      end

      def needs_arg?
        false
      end
      
      def multiple?
        @opts[:multiple]
      end
      
      def short_name
        @opts[:short] || name[0]
      end

      def index_in(tokens)
        tokens.index("--#{name}") || tokens.index("-#{short_name}")
      end
    end
  end
end