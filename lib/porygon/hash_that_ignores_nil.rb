module Porygon
  class HashThatIgnoresNil < Hash
    def []=(key, value)
      super unless value.nil?
    end
  end
end