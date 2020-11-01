module Resolvers
  class FixedSizeResolver < GenericResolver
    def consume(parser)
      if parser.tokens.size >= token_size
        find_at_start(parser) || find_at_end(parser)
      end 
    end

    def token_size
      1
    end

    private

    def find_at_start(parser)
      range = 0..(token_size - 1)
      arg = parser.tokens[range].join(' ')
      value = call(arg, parser.command)

      [range, arg, value]
    rescue Commands::ResolveError
      nil
    end

    def find_at_end(parser)
      range = ((token_size)..(parser.tokens.size - token_size))
      arg = parser.tokens[range].join(' ')
      value = call(arg, parser.command)

      [range, arg, value]
    end
  end
end