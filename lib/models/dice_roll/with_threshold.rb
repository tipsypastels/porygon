class DiceRoll
  class WithThreshold < self
    COMPARE_FUNCS = {
      '='  => -> v, t { v == t },
      '>'  => -> v, t { v > t },
      '<'  => -> v, t { v < t },
      '>=' => -> v, t { v >= t },
      '<=' => -> v, t { v <= t },
    }
    
    def initialize(t_sign:, t_num:, **opts)
      super(**opts)

      @threshold    = t_num
      @compare_sign = t_sign
      @comparer     = COMPARE_FUNCS.fetch(t_sign)
      @passes       = 0
    end

    def increase_by(value)
      super
      @passes += 1 if pass?(value)
    end

    def pass_fail
      "#{@passes} / #{size - @passes}" if size > 1
    end
    
    def threshold
      "\\#{@compare_sign} #{@threshold}" if size > 1
    end
    
    def to_s
      map { |value| "#{value} #{yield pass?(value)}" }.join(', ')
    end
    
    private

    def pass?(value)
      @comparer.call(value, @threshold)
    end
  end
end