module Arguments
  class Plain
    def initialize(key)
      @key = key
    end

    def parse(args, *)
      args
    end
  end
end