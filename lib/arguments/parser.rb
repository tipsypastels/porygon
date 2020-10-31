module Arguments
  # A complex parser that supports multiple arguments, resolvers, and flags.
  class Parser
    attr_reader :opts, :defs
    delegate :usage, :validate!, to: :defs

    def initialize(&block)
      if block
        @defs = ExecutionEnvironment.call(&block)
        @defs.validate!
      else
        @defs = DefinitionList.new
      end
    end

    def parse(raw_args, command)
      ParseOperation.new(self, raw_args, command).parse
    end
  end
end