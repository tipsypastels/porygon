class Arguments
  class Parser
    def self.parse(...)
      new(...).parse
    end

    delegate :each, :each_default, :first_missing, to: :@stack
    
    def initialize(tokens, command, stack)
      @tokens  = tokens
      @command = command
      @stack   = stack
      @output  = {}.with_indifferent_access
    end

    def parse
      eat_opts
      apply_defaults
      check_required

      Result.new(@output)
    end
    
    private
    
    def eat_opts
      each { |opt| opt.eat(@tokens, @output, @command) }
    end

    def apply_defaults
      each_default { |opt, value| @output[opt] ||= resolve_default(value) }
    end

    def check_required
      if (missing = first_missing(@output))
        raise Commands::RuntimeError.new 'missing_arg', arg: missing
      end
    end

    def resolve_default(value)
      value.is_a?(Proc) ? value.call : value
    end
  end
end