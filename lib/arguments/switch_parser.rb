module Arguments
  # A variant on +Parser+ which supports multiple different argument formats in
  # a single command. The first format to parse without raising will be used.
  class SwitchParser
    delegate :usage, to: :@formats

    def initialize(&block)
      @formats = ExecutionEnvironment.call(&block)
      @formats.validate!
    end

    def parse(raw_args, command)
      res = 
        @formats.detect do |_key, parser|
          parser.parse(raw_args, command)
        rescue
          next
        end

      raise_on_missing unless res
      
      ResultWrapperWithDynamicMethod.new(*res)
    end

    private

    def raise_on_missing
      raise Commands::UsageError, 'switch_parser.no_format_matches'
    end
  end
end