module Resolvers
  class CommandResolver < FixedSizeResolver
    def call(value, _command)
      Commands::TAGS[value.downcase] || err('missing', value)
    end
  end
end