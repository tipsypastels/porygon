module Arguments
  class Parser
    class ArrayDefinition
      attr_reader :name, :type, :size, :default

      def initialize(name, type, size:, optional: false, default: nil)
        @name = name
        @type = type
        @size = size

        @default  = default
        @optional = optional
      end

      def optional?
        @optional
      end

      def >>(other)
        other.args << self
      end
    end
  end
end