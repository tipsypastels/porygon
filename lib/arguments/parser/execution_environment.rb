module Arguments
  class Parser
    # A disposable container for executing the block given to +Parser+'s
    # initializer, and constructing the argument objects based on that.
    class ExecutionEnvironment
      include Resolvers

      def self.call(&block)
        new(&block).result
      end
      
      def initialize
        @defs = DefinitionList.new
        yield self        
      end
      
      def result
        @defs
      end

      def arg(name, type, **opts)
        @defs << ArgDefinition.new(name, type, **opts)
      end

      def flag(name, type, **opts)
        @defs << 
          if type == Resolvers::BoolResolver
            BoolFlagDefinition.new(name, **opts)
          else
            FlagWithArgDefinition.new(name, type, **opts)
          end
      end
    end
  end
end