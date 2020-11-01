module Resolvers
  class KeywordResolver < FixedSizeResolver
    attr_reader :keyword
    
    def initialize(keyword, casecmp: true)
      @keyword = keyword
      @casecmp = casecmp
    end

    def call(value, _command)
      has = @casecmp ? value.casecmp?(keyword) : value == keyword
      has || err('missing', value)      
    end

    def token_size
      @token_size ||= keyword.split.size
    end

    def usage(*)
      keyword
    end

    def skip_default_usage_wrap?
      true
    end
  end
end