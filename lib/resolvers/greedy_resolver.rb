module Resolvers
  class GreedyResolver < GenericResolver
    def consume(parser)
      if parser.tokens.present?
        [0..(parser.tokens.size - 1), parser.tokens.join(' ')]
      end
    end

    def consume_last?
      true
    end
  end
end