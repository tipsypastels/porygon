class DiceRoll
  include Enumerable

  def self.from_argument(error, arg, *)
    Builder.build(error, arg)
  end

  attr_reader :count, :faces, :offset, :total
  delegate :each, :size, to: :values

  def initialize(count: 1, faces: 6, offset: 0)
    @total     = 0
    @count     = count
    @faces     = faces
    @offset    = offset
  end

  def values
    @values ||= Array.new(count) { Value.new(self) }
  end

  def increase_by(value)
    @total += value
  end

  def rand
    Kernel.rand(1..faces) + offset
  end

  def to_s
    values.join(', ')
  end

  def display_total
    total if size > 1
  end

  def threshold; end
  def pass_fail; end
end