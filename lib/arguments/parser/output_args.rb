module Arguments
  class Parser
    # The result of a successful parse operation.
    class OutputArgs < OpenStruct
      def initialize(*)
        super
        freeze
      end

      def any?
        to_h.present?
      end
    end
  end
end