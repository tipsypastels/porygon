module Resolvers
  class PackageResolver < FixedSizeResolver
    def call(value, _command)
      Packages::TAGS[value.downcase] || err('missing', value)
    end
  end
end