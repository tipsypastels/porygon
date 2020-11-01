module Resolvers
  class BoolResolver < FixedSizeResolver
    TRUE  = %w[true yes on ok ye ya yeah yep]
    FALSE = %w[false no off nope]

    def call(value, _command)
      return true  if value.in?(TRUE)
      return false if value.in?(FALSE)
      
      err('unparsable', value: value)
    end
  end
end