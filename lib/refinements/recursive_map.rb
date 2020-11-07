module Refinements
  module RecursiveMap
    refine Hash do
      def recursive_map(&block)
        map { |key, elem|
          case elem
          when Hash, Array
            [key, elem.recursive_map(&block)]
          else
            [key, yield(elem)]
          end
        }.to_h
      end
    end

    refine Array do
      def recursive_map(&block)
        map do |elem|
          case elem
          when Hash, Array
            elem.recursive_map(&block)
          else
            yield elem
          end
        end
      end
    end
  end
end