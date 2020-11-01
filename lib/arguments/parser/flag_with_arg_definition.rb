module Arguments
  class Parser
    # A flag that takes one arg. Multiple args are not supported.
    class FlagWithArgDefinition
      attr_reader :name, :type, :default

      def initialize(name, type, default: nil, optional: false)
        @name = name
        @type = type

        @default  = default
        @optional = optional
      end

      def short_name
        name[0]
      end

      def >>(other)
        other.flags << self
      end

      def optional?
        @optional
      end

      def validate!
        # no-op
      end
      
      def to_usage(command)
        if default
          wrap_for_usage("--#{name} #{type_to_usage(command)}=#{default}")
        else
          wrap_for_usage("--#{name} #{type_to_usage(command)}")
        end
      end

      def consume(parser)
        unless (idx = parser.flag_index(self))
          return if optional?
          return parser.set(self, default) if default

          parser.missing(self)
        end

        arg = parser.flag_arg(idx, self)

        value = convert_to_type(arg, parser)
        parser.set(self, value, idx..(idx + 1))
      end

      private

      def type_to_usage(command)
        type.usage(self, command)
      end

      def wrap_for_usage(string)
        if type.skip_default_usage_wrap?
          return string
        end
        
        if optional? || default
          "[#{string}]"
        else
          string
        end
      end

      def convert_to_type(value, parser)
        type.call(value, parser.command)
      end
    end
  end
end