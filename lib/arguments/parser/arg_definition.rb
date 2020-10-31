module Arguments
  class Parser
    # A definition of an argument used by the parser.
    class ArgDefinition
      attr_reader :name, :type

      def initialize(name, type, **opts)
        @name  = name
        @type  = type
        @opts  = opts
      end

      def validate!
        # no-op
      end

      def optional?
        @opts[:optional]
      end

      def default
        @opts[:default]
      end

      def to_usage(command)
        if default
          wrap_for_usage("#{type_to_usage(command)}=#{default}")
        else
          wrap_for_usage(type_to_usage(command))
        end
      end

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
          "<#{string}>"
        end
      end
    end
  end
end