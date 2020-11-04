class DiceRoll
  include Enumerable, FromArgument

  ARG_INT             = /^([1-9][0-9]*)$/
  ARG_ROLL            = /^([1-9][0-9]*)d([1-9][0-9]*)$/
  ARG_ROLL_POS_OFFSET = /^([1-9][0-9]*)d([1-9][0-9]*)\+(\d+)$/
  ARG_ROLL_NEG_OFFSET = /^([1-9][0-9]*)d([1-9][0-9]*)\-(\d+)$/

  MAX = 100

  class << self
    def default
      new
    end

    def from_argument(arg)
      case arg
      when ARG_INT
        new(*check_max($1.to_i))
      when ARG_ROLL 
        new(*check_max($1.to_i, $2.to_i))
      when ARG_ROLL_POS_OFFSET
        new(*check_max($1.to_i, $2.to_i, $3.to_i))
      when ARG_ROLL_NEG_OFFSET
        new(*check_max($1.to_i, $2.to_i, -$3.to_i))
      else
        error(:malformed, arg: arg)
      end
    end

    private

    def check_max(*values)
      values.each { error(:over_max, arg: _1, no_help: true) if _1 > MAX }
    end
  end

  attr_reader :count, :faces, :offset
  delegate :each, :size, to: :values

  def initialize(count = 1, faces = 6, offset = 0)
    @count  = count
    @faces  = faces
    @offset = offset
  end

  def values
    @values ||= Array.new(count) { rand(1..faces) + offset }
  end

  def total
    @total ||= values.sum if size > 1
  end

  def threshold_from(threshold)
    @threshold ||= ThresholdResult.new(self, threshold) if threshold
  end

  def to_s
    values.join(', ')
  end

  class ThresholdResult
    delegate :size, to: :@roll
    delegate :to_s, to: :@threshold

    def initialize(roll, threshold)
      @roll         = roll
      @threshold    = threshold
    end

    def pass_fail
      "#{passes} / #{fails}"
    end

    private

    def passes
      @passes ||= @roll.inject(0) { |sum, val| pass?(val) ? sum + 1 : sum }
    end

    def fails
      size - passes
    end

    def pass?(value)
      value >= @threshold
    end
  end
  private_constant :ThresholdResult
end