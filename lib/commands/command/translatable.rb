module Commands
  class Command
    module Translatable
      extend ActiveSupport::Concern

      class_methods do
        def t(key, **interps)
          I18n.t(key, **interps, scope: "commands.#{tag}")
        end
      end

      included do
        delegate :t, to: :class
      end
    end
  end
end