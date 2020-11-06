class Color
  PATTERN = /\A#?(\h{3}|\h{6})\z/

  class << self
    def from_argument(error, arg, *)
      return error[:malformed, arg: arg] unless arg.match(PATTERN)
      from_s($1)
    end
    
    def from_s(hex)
      hex.gsub!(/(.)/, '\1\1') if hex.size == 3
      new(hex.to_i(16))
    end
  end

  attr_reader :red, :blue, :green

  def initialize(int)
    @int   = int
    @red   = (@int >> 16) & 0xFF
    @green = (@int >> 8) & 0xFF
    @blue  = @int & 0xFF
  end

  def to_i
    @int
  end
  alias combined to_i

  def to_s
    @int.to_s(16)
  end
  alias hex to_s

  def inspect
    "#<Color #{self}>"
  end
end