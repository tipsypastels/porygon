module Porygon
  class Version
    include Comparable, FromArgument

    class << self
      def current
        @current ||= new(ids.first)
      end

      def ids
        @ids ||= I18n.t('changelog').keys.map { |sym| sym.to_s.to_i }
      end

      def exist?(id)
        id.in? ids
      end

      def try_convert(arg)
        Integer(arg)
      rescue
        arg_err(:malformed, version: arg)
      end

      def from_argument(arg)
        arg.delete_prefix!('v')
        code = try_convert(arg)

        unless exist?(code)
          return arg_err(:nonexistant, version: code, current: current.id)
        end
         
        new(code)
      end
    end

    attr_reader :id
    delegate :<=>, to: :id

    def initialize(id)
      @id = id
    end

    def description
      I18n.t("changelog.#{id}.description", default: nil)
    end

    def changes
      I18n.t("changelog.#{id}.changes", default: nil)
    end

    def current?
      Version.current == self
    end
  end
end