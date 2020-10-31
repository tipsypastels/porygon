module Arguments
  # Wraps the result of an arguments parse, providing both the result
  # and the name of the alternative method to be called. Used internally
  # by +Arguments::SwitchParser+, but can be used by other argument
  # formats as well if needed.
  class ResultWrapperWithDynamicMethod
    DEFAULT = :__default__

    attr_reader :value
    
    def initialize(key, value)
      @key   = key
      @value = value
    end

    def call_method
      @key == DEFAULT ? :call : :"call_#{@key}"
    end
  end
end