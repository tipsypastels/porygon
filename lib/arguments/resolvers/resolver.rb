module Arguments
  module Resolvers
    # Resolver is a combination of a proc and a struct. It's mainly used as the
    # former, but we also need to be able to get parameters off it to introspect
    # later, such as when printing usage for a command. 
    class Resolver < OpenStruct
      def self.new(**opts, &block)
        name = caller_locations(1, 1)[0].label
        super(name, **opts, &block)
      end

      attr_reader :name

      def initialize(name, **opts, &block)
        @name = name
        
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

      def consume_until_valid(parser)
        tokens = []
        arg    = nil
        value  = nil
        all_tokens = parser.tokens.dup
        
        while (next_token = all_tokens.pop)
          begin
            tokens << next_token
            arg = tokens.join(' ')
            value = call(arg, parser.command)
          rescue => e
            next if all_tokens.present?
            raise e
          end
        end

        [tokens.size, arg, value] if value
      end

      private

      def err(i18n_key, value, **interps)
        Resolvers.err(i18n_key, value, **interps)
      end
    end
  end
end