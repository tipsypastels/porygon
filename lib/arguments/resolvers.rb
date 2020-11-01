module Arguments
  # :nodoc:
  module Resolvers
    class << self
      def string
        Resolver.new do
          def call(value, _command)
            value.to_s
          end

          def consume_until_valid(parser)
            if parser.tokens.size > 0
              [parser.tokens.size, parser.tokens.join(' ')]
            end
          end
        end
      end

      def int(range = nil)
        Resolver.new(range: range) do
          def call(value, _command)
            Integer(value).tap { check_range(_1, value) if range }
          rescue ArgumentError, TypeError
            err('int.invalid', value)
          end

          def check_range(int, value)
            int.in?(range) || err('int.out_of_range', value, range: range)
          end
        end
      end

      BOOLEAN_TRUE  = %w[true yes on ok ye ya yeah yep]
      BOOLEAN_FALSE = %w[false no off nope]

      def bool
        Resolver.new do
          def call(value, _command)
            return true  if value.in?(BOOLEAN_TRUE)
            return false if value.in?(BOOLEAN_FALSE)

            err('bool.unparsable', value: value)
          end
        end
      end

      def keyword(keyword, case_sensitive: false)
        Resolver.new(keyword: keyword, case_sensitive: case_sensitive) do
          def call(value, _command)
            has = case_sensitive ? (value == keyword) : value.casecmp?(keyword)
            has || err('keyword.missing', value)
          end

          def usage(_arg, _command)
            keyword
          end

          def skip_default_usage_wrap?
            true
          end
        end
      end

      def package
        Resolver.new do
          def call(value, _command)
            Packages::TAGS[value.downcase] || err('package.missing', value)
          end
        end
      end

      def command
        Resolver.new do
          def call(value, _command)
            Commands::TAGS[value.downcase] || err('command.missing', value)
          end
        end
      end

      def equation_result
        Resolver.new do
          def call(value, _command)
            Dentaku(value)
          rescue => e
            err('equation_result.error', value, error: e)
          end
        end
      end

      def array_of_strings(range = 1.., delim: /, */)
        Resolver.new(range: range, demim: delim) do
          def call(value, _command)
            value.split(delim).tap { check_in_range(_1, range) }
          end

          def check_in_range(ary, range)
            ary.size.in?(range) || 
              err('array_of_strings.out_of_range', value, range: range)
          end
        end
      end

      def err(i18n_key, value, **interps)
        raise Commands::ResolveError.new i18n_key,
                                         value: value,
                                         **interps
      end
    end
  end
end