module Arguments
  class Parser
    # Errors specific to +Arguments::Parser+, both static and at runtime.
    # The latter will be cought on command usage and displayed to the user.
    module Errors
      StaticParserError = Class.new(StandardError)

      # :nodoc: 
      class InvalidDefinition < StaticParserError
        def initialize(key)
          super Errors.t("invalid_definition.#{key}")
        end
      end

      def self.t(key, **interps)
        I18n.t("arguments.parser.errors.#{key}", **interps)
      end
    end
  end
end