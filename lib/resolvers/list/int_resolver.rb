module Resolvers
  class IntResolver < FixedSizeResolver
    def initialize(range = nil)
      @range = range
    end

    def call(value, _command)
      int = Integer(value)
      check_range(int, value) if @range
      int
    rescue ArgumentError, TypeError
      err('invalid', value)
    end

    private

    def check_range(int, value)
      int.in?(@range) || err('out_of_range', value, range: @range)
    end
  end
end