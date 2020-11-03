class Arguments
  class Result < OpenStruct
    def initialize(...)
      super(...)
      freeze
    end
  end
end