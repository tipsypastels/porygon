module Porygon
  class HashWithLimitedSize < ::Hash
    attr_reader :max_size

    def initialize(max_size)
      super()
      @max_size = max_size
    end

    def []=(key, value)
      delete keys.first if size >= max_size
      super
    end
  end
end