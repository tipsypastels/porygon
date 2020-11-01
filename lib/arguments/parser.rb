module Arguments
  # A complex parser that supports multiple arguments, resolvers, and flags.
  class Parser
    attr_reader :opts, :defs
    delegate :usage, :validate!, to: :defs

    def initialize(**opts, &block)
      @opts = opts
      
      if block
        @defs = ExecutionEnvironment.call(&block)
        @defs.validate!
      else
        @defs = DefinitionList.new
      end
    end

    def parse(raw_args, command = nil)
      ParseOperation.new(self, raw_args, command).parse
    end

    def to_h(raw_args, command = nil)
      parse(raw_args, command).to_h
    end
  end
end