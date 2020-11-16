class DiceRoll
  class Builder
    FORMAT = /
      ^
        (?:
          (?<count>[1-9][0-9]*)
          (?:d(?<faces>[1-9][0-9]*))?
          (?<offset>[+-]\d+)?
        )?
        (?:
          (?<t_sign>=|!=|>|<|>=|<=)
          (?<t_num>\d+)
        )?
      $
    /x

    def self.build(error, arg)
      new(error, arg).build
    end

    attr_reader :match

    def initialize(error, arg)
      @error = error
      @match = find_match(arg)
    end

    def build
      out = Porygon::Util::HashThatIgnoresNil.new
      out[:count]  = get_clamped(:count, 1..100)
      out[:faces]  = get_clamped(:faces, 2..100)
      out[:offset] = get_int(:offset)
      out[:t_num]  = get_int(:t_num)
      out[:t_sign] = get(:t_sign)

      create_by_subclass(out)
    end

    private

    def create_by_subclass(out)
      klass = out[:t_num] ? DiceRoll::WithThreshold : DiceRoll
      klass.new(**out)
    end

    def get(key)
      @match[key]
    end

    def get_int(key)
      get(key)&.to_i
    end

    def get_clamped(key, range)
      get_int(key)&.clamp(range)
    end

    def find_match(arg)
      arg.delete(' ').match(FORMAT) || @error[:malformed, arg: arg]
    end
  end
end