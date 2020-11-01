module Resolvers
  class GenericResolver
    class << self
      delegate :call, :consume, :consume_last?,
              :usage, :skip_default_usage_wrap?,
              to: :new

      def [](*args, **opts)
        new(*args, **opts)
      end
    end

    def call(_value, _command)
      raise NotImplementedError, 'Resolver must define call.'
    end

    def consume(_parser)
      raise NotImplementedError, 'Resolver must define consume.'
    end

    def usage(arg, command)
      I18n.t arg.name, default: arg.name.to_s.upcase,
                        scope: [:commands, command.tag, :_arg_values]
    end

    def skip_default_usage_wrap?
      false
    end

    def consume_last?
      false
    end

    private

    def err(key, value, **interps)
      raise Commands::ResolveError.new "#{namespace_key}.#{key}",
                                        value: value,
                                        **interps
    end

    def namespace_key
      self.class.name.demodulize.underscore.sub('_resolver', '')
    end
  end
end