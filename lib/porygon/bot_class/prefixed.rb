module Porygon
  class BotClass
    module Prefixed
      extend ActiveSupport::Concern

      included do
        callback :setup_prefix_i18n, on: :init
      end

      def prefix
        @prefix ||= ENV.fetch('PREFIX') { '!' }
      end

      private

      def setup_prefix_i18n
        I18n.config.globals[:pre] = prefix
      end
    end
  end
end