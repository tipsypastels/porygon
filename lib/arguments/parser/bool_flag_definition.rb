module Arguments
  class Parser
    # A bool flag implies +true+ by its presence, it does not take an arg.
    class BoolFlagDefinition
      attr_reader :name

      def initialize(name, optional: false)
        @name     = name
        @optional = optional
      end

      def short_name
        name[0]
      end

      def optional?
        @optional
      end

      def >>(other)
        other.flags << self
      end

      def validate!
        validate_optional_type
      end

      def to_usage(_command)
        wrap_for_usage("--#{name}")
      end

      def consume(parser)
        idx = parser.flag_index(self)
        parser.set(self, true, idx) if idx
      end

      private
      
      def validate_optional_type
        unless optional?
          raise Commands::StaticError, 'parser.bool_flags_must_be_optional'
        end
      end

      def wrap_for_usage(string)
        "[#{string}]"
      end
    end
  end
end