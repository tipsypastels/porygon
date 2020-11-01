module Resolvers
  class VariableSizeResolver < GenericResolver 
    def consume(parser)
      tokens = []
      all_tokens = parser.tokens.dup
      
      while (next_token = all_tokens.shift)
        begin
          tokens << next_token
          arg = tokens.join(' ')
          value = call(arg, parser.command)
          break
        rescue => e
          next if all_tokens.present?
          raise e
        end
      end

      [0..(tokens.size - 1), arg, value] if value
    end
  end
end