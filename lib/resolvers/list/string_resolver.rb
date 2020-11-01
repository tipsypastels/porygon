module Resolvers
  class StringResolver < GreedyResolver
    def call(value, _command)
      value.to_s
    end
  end
end