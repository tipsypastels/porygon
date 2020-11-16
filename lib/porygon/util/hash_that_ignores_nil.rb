module Porygon
  module Util
    class HashThatIgnoresNil < Hash
      def []=(key, value)
        super unless value.nil?
      end
    end
  end
end