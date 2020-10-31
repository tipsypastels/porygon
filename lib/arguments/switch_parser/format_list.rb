module Arguments
  class SwitchParser
    # A list of possible named formats to use by the +SwitchParser+, where each
    # key is the prefix of the method variant that will be called with this
    # format, and the value is the parser.
    class FormatList
      include Enumerable

      delegate :[], :[]=, :each, to: :@formats
      
      def initialize
        @formats = {}
      end

      def validate!
        @formats.each_value(&:validate!)
      end

      def usage(command)
        @formats.values.collect { |parser| parser.usage(command) }
      end
    end
  end
end