module Resolvers
  class EquationResolver < VariableSizeResolver
    def call(value, _command)
      Dentaku(value)
    rescue => e
      err('error', value, error: e)
    end
  end
end