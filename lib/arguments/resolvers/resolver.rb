module Arguments
  module Resolvers
    # Resolver is a combination of a proc and a struct. It's mainly used as the
    # former, but we also need to be able to get parameters off it to introspect
    # later, such as when printing usage for a command. 
    class Resolver < OpenStruct
      def initialize(**opts, &block)
        super(**opts)
        instance_eval(&block)

        freeze
      end

      def call(_value, _command)
        raise NotImplementedError, 'Resolver must define call.'
      end

      def usage(arg, command)
        I18n.t arg.name, default: arg.name.to_s.upcase,
                         scope: [:commands, command.tag, :_arg_values]
      end

      def skip_default_usage_wrap?
        false
      end

      private

      def err(i18n_key, value, **interps)
        Resolvers.err(i18n_key, value, **interps)
      end
    end
  end
end