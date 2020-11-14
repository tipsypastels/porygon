module Porygon
  class BotClass
    module MarkovCaching
      extend ActiveSupport::Concern

      included do
        attr_reader :markov

        callback :init_markov, on: :init
      end

      private

      def init_markov
        @markov = MarkovStore.new
      end
    end
  end
end