class DiceRoll
  class Value
    include Comparable

    attr_reader :value

    def initialize(roll)
      @value = roll.rand
      roll.increase_by(@value)
    end

    def to_s
      @value.to_s
    end

    def <=>(other)
      case other
      when Value
        value <=> other.value
      when Integer
        value <=> other
      end
    end
  end
end